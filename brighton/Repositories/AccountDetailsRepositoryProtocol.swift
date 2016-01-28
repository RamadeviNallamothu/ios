
import Foundation

typealias FetchAccountDetailsCompletion = ([Account], NSError?) -> Void

protocol AccountDetailsRepositoryProtocol {
    func fetchAccountDetails(account: Account, completion: FetchAccountDetailsCompletion)
}