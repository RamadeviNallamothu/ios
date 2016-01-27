import Foundation

typealias HTTPClientCompletion = (NSData?, NSHTTPURLResponse?, NSError?) -> Void

protocol HTTPClientProtocol {
    func perform(request request: NSURLRequest, completion: HTTPClientCompletion) -> Void
}