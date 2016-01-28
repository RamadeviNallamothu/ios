import Quick
import Nimble
@testable import brighton

class AccountsViewControllerSpec: QuickSpec {
    override func spec() {
        var controller: AccountsViewController! // declare the object to be tested
        let accountsRepository = MockAccountsRepository()

        beforeEach() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            controller = storyboard.instantiateViewControllerWithIdentifier("AccountsViewController") as! AccountsViewController // instantiate the object to be tested
            controller.configure(accountsRepository: accountsRepository, asyncService: SyncService()) // if it's a view controller, configure the object to be tested
            controller.renderInNavController()
        }

        describe("when the app launches") {
            it("presents the login modal") {
                expect(controller.presentedViewController).to(beAnInstanceOf(LoginViewController)) // use the object to be tested and test it
            }
        }

        describe("when the login is successful") {
            beforeEach() {
                accountsRepository.fetchAccountsWasCalled = false
                let loginViewController = controller.presentedViewController as! LoginViewController
                if let delegate = loginViewController.delegate {
                    delegate.loginViewControllerLoginSuccessful()
                    NSRunLoop.mainRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 2))
                }
            }

            it("dismisses the login view controller") {
                expect(controller.presentedViewController).to(beNil())
            }

            it("makes a request to fetch accounts") {
                expect(accountsRepository.fetchAccountsWasCalled).to(beTrue())
            }

            describe("when the fetch completes") {
                context("with success") {
                    let account0 = Account(name: "Checking", type: "checking", balance: 12345.00)
                    let account1 = Account(name: "Savings", type: "savings", balance: 54321.99)

                    beforeEach() {
                        accountsRepository.fetchAccountsCompletion([account0, account1], nil)
                        controller.tableView?.layoutIfNeeded()
                    }

                    describe("displaying a list of accounts") {
                        var cells: [AccountCell] = []

                        beforeEach() {
                            if let tableView = controller.tableView {
                                cells = tableView.visibleCells as! [AccountCell]
                            }
                        }

                        it("displays account data in each cell") {
                            if let nameLabel = cells[0].nameLabel {
                                expect(nameLabel.text).to(equal("CHECKING"))
                            }
                            if let balanceLabel = cells[0].balanceLabel {
                                expect(balanceLabel.text).to(equal("$12,345.00"))
                            }
                        }
                    }

                    describe("when an account is tapped") {
                        beforeEach() {
                            if let tableView = controller.tableView {
                                let cell = tableView.visibleCells[0]
                                controller.performSegueWithIdentifier("ShowAccountDetailsSegue", sender: cell)
                                print("beforeEach")
                            }
                        }

                        it("pushes an account details view") {
                            expect(controller.navigationController?.topViewController).to(beAnInstanceOf(AccountDetailsViewController))
                        }

                        it("passes the account to the account details view") {
                            let viewController = controller.navigationController?.topViewController as! AccountDetailsViewController
                            expect(viewController.account).to(equal(account0))
                        }
                    }
                }

                context("with error") {

                }
            }

        }
    }
}
