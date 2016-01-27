import Quick
import Nimble
@testable import brighton

class RequestFactorySpec: QuickSpec {
    override func spec() {
        let requestFactory = RequestFactory()
        var requestData: NSURLRequest!

        describe("request for login"){
            beforeEach(){
                requestData = requestFactory.requestForLogin(username: "some username", password: "a password")
            }

            it("request has endpoint set"){
                expect(requestData.URL?.absoluteString).to(equal("https://brighton-dev.cfapps.io/login.json"))
            }

            it("request has HTTPMethod set"){
                expect(requestData.HTTPMethod).to(equal("POST"))
            }

            it("request has username and password set"){
                do {
                    let parsedJSON = try NSJSONSerialization.JSONObjectWithData(requestData.HTTPBody!, options: NSJSONReadingOptions())
                    expect(parsedJSON["username"]).to(equal("some username"))
                    expect(parsedJSON["password"]).to(equal("a password"))
                } catch {
                    expect(true).to(beFalse())
                }
            }

            it("request has header fields set"){
                expect(requestData.allHTTPHeaderFields!["Content-Type"]).to(equal("application/json"))
            }
        }

        describe("request for fetching accounts") {
            beforeEach(){
                requestData = requestFactory.requestForAccounts()
            }

            it("request has endpoint set"){
                expect(requestData.URL?.absoluteString).to(equal("https://brighton-dev.cfapps.io/accounts.json"))
            }

            it("request has HTTPMethod set"){
                expect(requestData.HTTPMethod).to(equal("GET"))
            }

            it("request has header fields set"){
                expect(requestData.allHTTPHeaderFields!["Content-Type"]).to(equal("application/json"))
            }
        }
    }
}