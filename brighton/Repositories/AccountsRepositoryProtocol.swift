import Foundation

typealias FetchAccountsCompletion = ([Account], NSError?) ->Void

protocol AccountsRepositoryProtocol {
    func fetchAccounts(completion: FetchAccountsCompletion)
}