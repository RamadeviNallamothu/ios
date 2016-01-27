import Foundation

class RequestFactory: RequestFactoryProtocol, AccountsRequestFactoryProtocol {
    let baseURL = NSBundle.mainBundle().objectForInfoDictionaryKey("BASE_URL") as! String

    func requestForLogin(username username: String, password: String) -> NSURLRequest {
        let url = NSURL(string: baseURL + "/login.json")!as NSURL
        let request = NSMutableURLRequest.init(URL: url)
        request.HTTPMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        let body = [ "username": username, "password": password ]
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions())
        } catch {
            print("Error serializing JSON")
        }
        return request
    }

    func requestForAccounts() -> NSURLRequest {
        let url = NSURL(string: baseURL + "/accounts.json")!as NSURL
        let request =  NSMutableURLRequest.init(URL: url)
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        return request
    }

}