import UIKit

class AccountsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.performSegueWithIdentifier("PresentLoginSceneSegue", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "PresentLoginSceneSegue") {
            let loginViewController = segue.destinationViewController as! LoginViewController
            loginViewController.configure(self)
        }
    }

}

extension AccountsViewController: LoginViewControllerDelegate {
    func loginViewControllerLoginSuccessful() {
        self.dismissViewControllerAnimated(true) {}
    }
}
