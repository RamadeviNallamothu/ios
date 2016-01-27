import Foundation
@testable import brighton

class MockURLSession: URLSessionProtocol {
    var request: NSURLRequest!
    var mockURLSessionDataTask: URLSessionDataTaskProtocol!
    var completion: DataTaskResult = {(data, response, error) -> Void in }

    func dataTaskWithRequest(request: NSURLRequest, completionHandler: DataTaskResult) -> URLSessionDataTaskProtocol {
        self.request = request
        self.completion = completionHandler
        return mockURLSessionDataTask
    }
}
