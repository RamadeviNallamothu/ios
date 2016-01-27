
import Foundation

class AccountsRepository: AccountsRepositoryProtocol {
    // static dependencies of AccountsRepository, because AccountsRepository "depends" on them to do its work
    let httpClient: HTTPClientProtocol
    let requestFactory: AccountsRequestFactoryProtocol
    let accountSerializer: AccountSerializerProtocol = AccountSerializer()

    convenience init() {
        self.init(requestFactory: RequestFactory(), httpClient: HTTPClient())
    }

    // allow other classes (such as test classes) to inject AccountsRepository's dependencies into AccountsRepository
    init(requestFactory: AccountsRequestFactoryProtocol, httpClient: HTTPClientProtocol) {
        self.requestFactory = requestFactory
        self.httpClient = httpClient
    }

    func fetchAccounts(completion: FetchAccountsCompletion) {
        httpClient.perform(request: requestFactory.requestForAccounts()) {
            (data, response, error) -> Void in
            var accounts: [Account] = []
            if let data = data {
                do{
                    let dict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
                    accounts = self.accountSerializer.accountsFromDictionary(dict as! Dictionary<String, [Dictionary<String, AnyObject>]>)
                } catch {
                    print("--------> error parsing JSON")
                }
            }
            completion(accounts, error)
        }
    }
}