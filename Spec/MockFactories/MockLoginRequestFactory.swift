@testable import brighton
import Foundation

class MockLoginRequestFactory: LoginRequestFactoryProtocol {
    var mockedLoginRequest: NSURLRequest!

    func requestForLogin(username username: String, password: String) -> NSURLRequest {
        if (username == kTestUsername && password == kTestPassword) {
            return mockedLoginRequest
        }
        return NSURLRequest(URL: NSURL(string: "http://example.com")!)
    }
}

