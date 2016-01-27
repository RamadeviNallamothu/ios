import Foundation
@testable import brighton

class MockAccountsRequestFactory: AccountsRequestFactoryProtocol {
    let mockedFetchAccountsRequest = NSURLRequest()

    func requestForAccounts() -> NSURLRequest {
        return mockedFetchAccountsRequest
    }

}

