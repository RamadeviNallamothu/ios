import Quick
import Nimble
@testable import brighton

class AccountsViewControllerSpec: QuickSpec {
    override func spec() {
        var controller: AccountsViewController!

        beforeEach() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            controller = storyboard.instantiateViewControllerWithIdentifier("AccountsViewController") as! AccountsViewController
            let navController = UINavigationController(rootViewController: controller)
            if let window = UIApplication.sharedApplication().delegate?.window {
                window!.rootViewController = navController
                NSRunLoop.mainRunLoop().runUntilDate(NSDate())
            }
        }

        describe("when the app launches") {
            it("presents the login modal") {
                expect(controller.presentedViewController).to(beAnInstanceOf(LoginViewController))
            }
        }

        describe("when the login is successful") {
            beforeEach() {
                let loginViewController = controller.presentedViewController as! LoginViewController
                if let delegate = loginViewController.delegate {
                    delegate.loginViewControllerLoginSuccessful()
                    NSRunLoop.mainRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 1))
                }
            }

            it("dismisses the login view controller") {
                expect(controller.presentedViewController).to(beNil())
            }
        }
    }
}
