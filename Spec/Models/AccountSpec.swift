import Quick
import Nimble
@testable import brighton

class AccountSpec: QuickSpec {
    override func spec() {
        var account: Account!

        beforeEach() {
            account = Account(name: "An Account", type: "a type", balance: 123.45)
        }

        describe("equality") {
            var otherAccount: Account!

            context("when other account equals account") {
                it("returns true") {
                    otherAccount = Account(name: "An Account", type: "a type", balance: 123.45)
                    expect(account == otherAccount).to(beTrue())
                }
            }

            context("when other account has a different name") {
                it("returns false") {
                    otherAccount = Account(name: "Other Account", type: "a type", balance: 123.45)
                    expect(account == otherAccount).to(beFalse())
                }
            }

            context("when other account has a different type") {
                it("returns false") {
                    otherAccount = Account(name: "An Account", type: "other type", balance: 123.45)
                    expect(account == otherAccount).to(beFalse())
                }
            }

            context("when other account has a different balance") {
                it("returns false") {
                    otherAccount = Account(name: "An Account", type: "a type", balance: 543.21)
                    expect(account == otherAccount).to(beFalse())
                }
            }
        }
    }
}
