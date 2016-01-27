import Foundation

class AuthenticationRepository: AuthenticationRepositoryProtocol {
    let requestFactory: LoginRequestFactoryProtocol
    let httpClient: HTTPClientProtocol

    convenience init() {
        self.init(requestFactory: RequestFactory(), httpClient: HTTPClient())
    }

    init(requestFactory: LoginRequestFactoryProtocol, httpClient: HTTPClientProtocol) {
        self.requestFactory = requestFactory
        self.httpClient = httpClient
    }

    func login(username username: String, password: String, completion: LoginCompletion) {
        httpClient.perform(request: requestFactory.requestForLogin(username: username, password: password)) {
            (data, response, error) -> Void in
            if let response = response {
                var error: NSError? = nil
                if (response.statusCode == 401) {
                    error = NSError(domain: "AuthenticationError", code: 0, userInfo: nil)
                }
                completion(error)
            }
        }
    }
}