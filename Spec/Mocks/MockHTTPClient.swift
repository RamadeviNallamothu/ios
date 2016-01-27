import Foundation
@testable import brighton

class MockHTTPClient: HTTPClientProtocol {
    var performWasCalled: Bool = false
    var performRequest: NSURLRequest!
    var performCompletion: HTTPClientCompletion!

    func perform(request request: NSURLRequest, completion: HTTPClientCompletion) {
        performWasCalled = true
        self.performRequest = request
        self.performCompletion = completion
    }
}