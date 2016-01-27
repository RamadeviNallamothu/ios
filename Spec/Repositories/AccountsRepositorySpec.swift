import Quick
import Nimble
@testable import brighton

class AccountsRepositorySpec: QuickSpec {

    override func spec() {

        // create mock dependencies of each of AccountRepository's dependencies
        let requestFactory = MockAccountsRequestFactory()
        let urlSession = MockURLSession()
        let task = MockURLSessionDataTask()

        var accountsRepository: AccountsRepository!

        beforeEach(){
            urlSession.mockURLSessionDataTask = task
            // inject the mock dependencies into AccountsRepository, so that it uses our mocks instead of live objects
            accountsRepository = AccountsRepository(requestFactory: requestFactory, urlSession: urlSession) // Dependency Injection
        }

        describe("fetching accounts") {
            var callbackCalled: Bool = false
            var callbackAccounts: [Account]?
            var callbackError : ErrorType?

            beforeEach() {
                callbackCalled = false
                accountsRepository.fetchAccounts({
                    (accounts, error) -> Void in
                    callbackCalled = true
                    callbackAccounts = accounts
                    callbackError = error

                })
            }

            it("makes a fetch-accounts request") {
                expect(urlSession.request).to(equal(requestFactory.mockedFetchAccountsRequest))
            }

            it("calls resume on the returned task") {
                expect(task.resumeWasCalled).to(beTrue())
            }

            describe("when the request returns") {
                context("with success") {
                    let account0 = Account(name: "account 0", type: "type 0", balance: 123.45)
                    let account1 = Account(name: "account 1", type: "type 1", balance: 234.56)

                    beforeEach() {
                        let data = fixtureData("accounts.200.json")
                        urlSession.completion(data, nil, nil)
                    }

                    it("calls its callback") {
                        expect(callbackCalled).to(beTrue())
                    }

                    it("passes the array of accounts to the callback") {
                        expect(callbackAccounts).to(equal([account0, account1]))
                    }

                    it("passes a nil error to the callback") {
                        expect(callbackError).to(beNil())
                    }
                }

                context("with error") {
                    beforeEach() {
                        let accountsDictionary =  []
                        var data : NSData?

                        do {
                             data = try NSJSONSerialization.dataWithJSONObject(accountsDictionary, options: NSJSONWritingOptions())
                            urlSession.completion(data, nil, NSError(domain: "FetchAccountError", code: 0, userInfo: nil))
                        } catch {
                        }
                    }

                    it("calls its callback") {
                        expect(callbackCalled).to(beTrue())
                    }

                    it("passes a empty array of accounts to the callback") {
                        expect(callbackAccounts).to(beEmpty())
                    }

                    it("passes an error to the callback") {
                        expect(callbackError).toNot(beNil())
                    }
                }
            }
        }

        describe("fetching a single account") {

        }
    }
}
