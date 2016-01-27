import Foundation

extension NSURLSession: URLSessionProtocol {
    func dataTaskWithRequest(request: NSURLRequest, completionHandler: DataTaskResult)
        -> URLSessionDataTaskProtocol
    {
        return (dataTaskWithRequest(request, completionHandler: completionHandler) as NSURLSessionDataTask) as URLSessionDataTaskProtocol
    }
}
