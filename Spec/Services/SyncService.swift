import Foundation
@testable import brighton

class SyncService: AsyncProtocol {
    func performOnMainQueue(closure: () -> Void) {
        closure()
    }
}
