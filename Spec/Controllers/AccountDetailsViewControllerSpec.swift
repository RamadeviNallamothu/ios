import Quick
import Nimble
@testable import brighton

class AccountDetailsViewControllerSpec: QuickSpec {
    override func spec(){
        var controller : AccountDetailsViewController!
        let account = Account(name: "Checking", type: "checking", balance: 12345.00)

        beforeEach() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            controller = storyboard.instantiateViewControllerWithIdentifier("AccountDetailsViewController") as! AccountDetailsViewController
            controller.configure(account)
            controller.renderInNavController()
        }

        describe(" when the account details view launches") {
            it("sets the account name on the name label") {
                expect(controller.nameLabel?.text).to(equal("CHECKING"))
            }
            it ("sets the account balance on the balance label"){
                expect(controller.balancelabel?.text).to(equal("$12,345.00"))
            }
        }
    }
}
