import Foundation

class HTTPClient: HTTPClientProtocol {
    let urlSession: URLSessionProtocol

    convenience init() {
        self.init(urlSession: NSURLSession.sharedSession())
    }

    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }

    func perform(request request: NSURLRequest, completion: HTTPClientCompletion) {
        urlSession.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            if let httpResponse = response as? NSHTTPURLResponse {
                completion(data, httpResponse, error)
            }
        }.resume()
    }
}