import Foundation

protocol AccountSerializerProtocol {
    func accountFromDictionary(dict: Dictionary<String, AnyObject>) -> Account?
    func accountsFromDictionary(dict: Dictionary<String, [Dictionary<String, AnyObject>]>) -> [Account]
}