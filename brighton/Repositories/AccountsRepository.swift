import Foundation

class AccountsRepository: AccountsRepositoryProtocol {

    // static dependencies of AccountsRepository, because AccountsRepository "depends" on them to do its work
    let requestFactory: AccountsRequestFactoryProtocol
    let urlSession: URLSessionProtocol

    convenience init() {
        self.init(requestFactory: RequestFactory(), urlSession: NSURLSession.sharedSession())
    }

    // allow other classes (such as test classes) to inject AccountsRepository's dependencies into AccountsRepository
    init(requestFactory: AccountsRequestFactoryProtocol, urlSession: URLSessionProtocol) {
        self.requestFactory = requestFactory
        self.urlSession = urlSession
    }

    func fetchAccounts(completion: FetchAccountsCompletion) {
        urlSession.dataTaskWithRequest(requestFactory.requestForAccounts(),
            completionHandler: {
            (data, response, error) -> Void in
                var accounts: [Account] = []
                if let data = data {
                    do{
                        let dict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
                        if let jsonArray = dict["accounts"] {
                            for accountDict in jsonArray as! [Dictionary<String, AnyObject>] {
                                if let name = accountDict["name"],
                                       type = accountDict["type"],
                                       balance = accountDict["balance"]
                                {
                                    accounts.append(Account(name: name as! String, type: type as! String, balance: balance as! Float))
                                }
                            }
                        }
                    } catch {
                        print("--------> error parsing JSON")
                    }
                }
                completion(accounts, error)
        }).resume()
    }
}