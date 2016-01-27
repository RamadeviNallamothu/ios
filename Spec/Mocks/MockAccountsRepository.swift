import Foundation
@testable import brighton

class MockAccountsRepository: AccountsRepositoryProtocol {
    var fetchAccountsWasCalled: Bool = false
    var fetchAccountsCompletion: FetchAccountsCompletion = {(accounts, error) -> Void in }

    func fetchAccounts(completion: FetchAccountsCompletion) {
        fetchAccountsWasCalled = true
        fetchAccountsCompletion = completion
    }
}
