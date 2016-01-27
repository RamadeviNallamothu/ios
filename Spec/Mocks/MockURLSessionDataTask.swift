import Foundation
@testable import brighton

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var resumeWasCalled: Bool = false

    func resume() {
        resumeWasCalled = true
    }
}