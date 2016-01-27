import Foundation

protocol LoginRequestFactoryProtocol {
    func requestForLogin(username username: String, password: String) -> NSURLRequest
}
