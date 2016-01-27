import Quick
import Nimble
@testable import brighton

class AuthenticationRepositorySpec: QuickSpec {
    override func spec() {
        var authenticationRepository: AuthenticationRepository!
        let requestFactory = MockLoginRequestFactory()
        let httpClient = MockHTTPClient()

        beforeEach() {
            authenticationRepository = AuthenticationRepository(requestFactory: requestFactory, httpClient: httpClient)
        }

        describe("logging in") {
            var loginCompletionWasCalled: Bool = false
            var loginError: NSError? = nil

            beforeEach() {
                requestFactory.mockedLoginRequest = NSURLRequest()

                loginCompletionWasCalled = false
                authenticationRepository.login(username: kTestUsername, password: kTestPassword, completion: {
                    (error) -> Void in
                    loginCompletionWasCalled = true
                    loginError = error
                })
            }

            it("makes a request, configured with the username and password, to the log in endpoint") {
                expect(httpClient.performRequest).to(equal(requestFactory.mockedLoginRequest))
            }

            describe("when the request returns") {
                context("with success") {
                    beforeEach() {
                        let response = NSHTTPURLResponse(URL: NSURL(string: "http://example.com")!, statusCode: 200, HTTPVersion: nil, headerFields: nil)
                        httpClient.performCompletion(nil, response, nil)
                    }

                    it("calls its completion with nil error") {
                        expect(loginCompletionWasCalled).to(beTrue())
                        expect(loginError).to(beNil())
                    }
                }

                context("with error") {
                    beforeEach() {
                        let response = NSHTTPURLResponse(URL: NSURL(string: "http://example.com")!, statusCode: 401, HTTPVersion: nil, headerFields: nil)
                        httpClient.performCompletion(nil, response, nil)
                    }

                    it("calls its completion with an error") {
                        expect(loginCompletionWasCalled).to(beTrue())
                        expect(loginError).notTo(beNil())
                    }
                }
            }
        }
    }
}
