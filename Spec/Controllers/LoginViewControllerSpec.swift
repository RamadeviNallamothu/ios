import Quick
import Nimble
@testable import brighton

extension UIControl {
    func tap() {
        self.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
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
        let authenticationRepository = MockAuthenticationRepository()
        let delegate = MockLoginViewControllerDelegate()

        beforeEach() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            controller = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            controller.configure(authenticationRepository: authenticationRepository, delegate: delegate)
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

            beforeEach() {
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

            it("asks the authentication repository to log in") {
                expect(authenticationRepository.loginWasCalled).to(beTrue())
            }

            describe("when login returns") {
                context("with success") {
                    beforeEach() {
                        delegate.loginViewControllerLoginSuccessfulWasCalled = false
                        authenticationRepository.loginCompletion(nil)
                    }

                    it("notify the delegate that login was successful") {
                        expect(delegate.loginViewControllerLoginSuccessfulWasCalled).to(beTrue())
                    }
                }

                context("with error") {
                    beforeEach() {
                        delegate.loginViewControllerLoginSuccessfulWasCalled = false
                        authenticationRepository.loginCompletion(NSError(domain: "AuthenticationError", code: 0, userInfo: nil))
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
