import Foundation

typealias LoginCompletion = (NSError?) -> Void

protocol AuthenticationRepositoryProtocol {
    func login(username username: String, password: String, completion: LoginCompletion)
}