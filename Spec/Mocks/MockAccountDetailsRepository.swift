import Foundation
@testable import brighton

class MockAccountDetailsRepository: AccountDetailsRepositoryProtocol {
    var fetchAccountDetailsWasCalled: Bool = false
//    var fetchAccountsCompletion: FetchAccountsCompletion = {(accounts, error) -> Void in }

    func fetchAccountDetails(account: Account, completion: FetchAccountDetailsCompletion) {
//        fetchAccountsWasCalled = true
//        fetchAccountsCompletion = completion
    }
}