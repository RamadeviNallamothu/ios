import Foundation
@testable import brighton

class MockAuthenticationRepository: AuthenticationRepositoryProtocol {
    var loginWasCalled: Bool = false
    var loginCompletion: LoginCompletion = {(error) -> Void in}
    var loginUsername: String = ""
    var loginPassword: String = ""

    func login(username username: String, password: String, completion: LoginCompletion) {
        self.loginWasCalled = true
        self.loginUsername = username
        self.loginPassword = password
        self.loginCompletion = completion
    }
}
