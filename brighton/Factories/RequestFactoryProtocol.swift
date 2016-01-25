import Foundation

protocol RequestFactoryProtocol {
    func requestForLogin(username username: String, password: String) -> NSURLRequest
}