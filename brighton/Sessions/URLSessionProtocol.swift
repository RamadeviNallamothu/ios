import Foundation

typealias DataTaskResult = (NSData?, NSURLResponse?, NSError?) -> Void

protocol URLSessionProtocol {
    func dataTaskWithRequest(request: NSURLRequest, completionHandler: DataTaskResult)
        -> URLSessionDataTaskProtocol
}