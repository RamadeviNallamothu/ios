import Quick
import Nimble
@testable import brighton

extension UIControl {
    func tap() {
        self.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
    }
}

let kTestUsername = "my username"
let kTestPassword = "my password"

class MockRequestFactory: RequestFactoryProtocol {
    var mockedLoginRequest: NSURLRequest!
    
    func requestForLogin(username username: String, password: String) -> NSURLRequest {
        if (username == kTestUsername && password == kTestPassword) {
            return mockedLoginRequest
        }
        return NSURLRequest(URL: NSURL(string: "http://example.com")!)
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var resumeWasCalled: Bool = false

    func resume() {
        resumeWasCalled = true
    }
}

class MockURLSession: URLSessionProtocol {
    var loginRequest: NSURLRequest!
    var mockURLSessionDataTask: URLSessionDataTaskProtocol!
    var loginCompletion: DataTaskResult = {(data, response, error) -> Void in }

    func dataTaskWithRequest(request: NSURLRequest, completionHandler: DataTaskResult) -> URLSessionDataTaskProtocol {
        self.loginRequest = request
        self.loginCompletion = completionHandler
        return mockURLSessionDataTask
    }
}

class MockLoginViewControllerDelegate: LoginViewControllerDelegate {
    var loginViewControllerLoginSuccessfulWasCalled: Bool = false

    func loginViewControllerLoginSuccessful() {
        loginViewControllerLoginSuccessfulWasCalled = true
    }
}


class LoginViewControllerSpec: QuickSpec {
    override func spec() {
        var controller : LoginViewController!
        let requestFactory = MockRequestFactory()
        let urlSession = MockURLSession()
        let delegate = MockLoginViewControllerDelegate()

        beforeEach() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            controller = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            controller.configure(requestFactory: requestFactory, urlSession: urlSession, delegate: delegate)
            if let window = UIApplication.sharedApplication().delegate?.window {
                window!.rootViewController = controller
                NSRunLoop.mainRunLoop().runUntilDate(NSDate())
            }
        }

        describe("when the view appears") {
            it("has a username field") {
                expect(controller.usernameTextField).toNot(beNil())
            }

            it("has a password field") {
                expect(controller.passwordTextField).toNot(beNil())
            }

            it("has a submit button") {
                expect(controller.submitButton).toNot(beNil())
            }
        }

        describe("when the 'Log In' button is tapped") {
            let mockURLSessionDataTask = MockURLSessionDataTask()

            beforeEach() {
                requestFactory.mockedLoginRequest = NSURLRequest()
                urlSession.mockURLSessionDataTask = mockURLSessionDataTask

                if let usernameTextField = controller.usernameTextField,
                       passwordTextField = controller.passwordTextField
                {
                    usernameTextField.text = kTestUsername
                    passwordTextField.text = kTestPassword
                }
                if let submitButton = controller.submitButton {
                    submitButton.tap()
                }
            }

            it("makes a request, configured with the username and password, to the log in endpoint") {
                expect(urlSession.loginRequest).to(equal(requestFactory.mockedLoginRequest))
            }

            it("calls resume on the task") {
                expect(mockURLSessionDataTask.resumeWasCalled).to(beTrue())
            }

            describe("when the request returns") {
                context("with success") {
                    beforeEach() {
                        delegate.loginViewControllerLoginSuccessfulWasCalled = false
                        let response = NSHTTPURLResponse(URL: NSURL(string: "http://example.com")!, statusCode: 200, HTTPVersion: nil, headerFields: nil)
                        urlSession.loginCompletion(nil, response, nil)
                    }

                    it("notify the delegate that login was successful") {
                        expect(delegate.loginViewControllerLoginSuccessfulWasCalled).to(beTrue())
                    }
                }

                context("with error") {
                    beforeEach() {
                        delegate.loginViewControllerLoginSuccessfulWasCalled = false
                        let response = NSHTTPURLResponse(URL: NSURL(string: "http://example.com")!, statusCode: 401, HTTPVersion: nil, headerFields: nil)
                        urlSession.loginCompletion(nil, response, nil)
                    }

                    it("does something that we'll figure out later") {
                    }

                    it("does not notify the delegate to dismiss it") {
                        expect(delegate.loginViewControllerLoginSuccessfulWasCalled).to(beFalse())
                    }
                }
            }
        }
    }
}
