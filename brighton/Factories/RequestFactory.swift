import Foundation

class RequestFactory {
    let baseURL = NSBundle.mainBundle().objectForInfoDictionaryKey("BASE_URL") as! String

    func baseRequest(path path: String) -> NSMutableURLRequest {
        let url = NSURL(string: baseURL + path)!as NSURL
        let request = NSMutableURLRequest.init(URL: url)
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        return request
    }
}

extension RequestFactory: LoginRequestFactoryProtocol {
    func requestForLogin(username username: String, password: String) -> NSURLRequest {
        let request = baseRequest(path: "/login.json")
        request.HTTPMethod = "POST"
        let body = [ "username": username, "password": password ]
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions())
        } catch {

            print("Error serializing JSON")
        }
        return request
    }
}

extension RequestFactory: AccountsRequestFactoryProtocol {
    func requestForAccounts() -> NSURLRequest {
        return  baseRequest(path: "/accounts.json")
    }
}