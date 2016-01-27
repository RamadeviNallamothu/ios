import Foundation

class AccountSerializer: AccountSerializerProtocol {
    func accountFromDictionary(dict: Dictionary<String, AnyObject>) -> Account? {
        if let name = dict["name"],
            type = dict["type"],
            balance = dict["balance"]
        {
            return Account(name: name as! String, type: type as! String, balance: balance as! Float)
        }
        return nil
    }

    func accountsFromDictionary(dict: Dictionary<String, [Dictionary<String, AnyObject>]>) -> [Account] {
        var accounts: [Account] = []
        if let jsonArray = dict["accounts"] {
            for accountDict in jsonArray {
                if let account = accountFromDictionary(accountDict) {
                    accounts.append(account)
                }
            }
        }
        return accounts
    }
}

