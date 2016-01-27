import Foundation

class AsyncService: AsyncProtocol {
    func performOnMainQueue(closure: () -> Void) {
        dispatch_async(dispatch_get_main_queue()) {
            closure()
        }
    }
}