import Foundation

class AuthenticationRepository: AuthenticationRepositoryProtocol {
    let requestFactory: LoginRequestFactoryProtocol
    let urlSession: URLSessionProtocol

    convenience init() {
        self.init(requestFactory: RequestFactory(), urlSession: NSURLSession.sharedSession())
    }

    init(requestFactory: LoginRequestFactoryProtocol, urlSession: URLSessionProtocol) {
        self.requestFactory = requestFactory
        self.urlSession = urlSession
    }

    func login(username username: String, password: String, completion: LoginCompletion) {
        urlSession.dataTaskWithRequest(requestFactory.requestForLogin(username: username, password: password)) {
            (data, response, error) -> Void in
            if let response = response {
                var error: NSError? = nil
                let httpResponse = response as! NSHTTPURLResponse
                if (httpResponse.statusCode == 401) {
                    error = NSError(domain: "AuthenticationError", code: 0, userInfo: nil)
                }
                completion(error)
            }
        }.resume()
    }
}