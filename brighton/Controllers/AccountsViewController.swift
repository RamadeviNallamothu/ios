import UIKit

class AccountsViewController: UIViewController {
    var accountsRepository: AccountsRepositoryProtocol? = AccountsRepository()
    var asyncService: AsyncProtocol? = AsyncService()
    var accounts: [Account] = []
    let currencyFormatter = NSNumberFormatter()

    @IBOutlet weak var tableView: UITableView?

    func configure(accountsRepository accountsRepository: AccountsRepositoryProtocol, asyncService: AsyncProtocol) {
        self.accountsRepository = accountsRepository
        self.asyncService = asyncService
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle

        self.performSegueWithIdentifier("PresentLoginSceneSegue", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "PresentLoginSceneSegue") {
            let loginViewController = segue.destinationViewController as! LoginViewController
            loginViewController.configure(self)
        }
    }

    func fetchAndDisplayAccounts() {
        if let accountsRepository = self.accountsRepository,
               asyncService = self.asyncService
        {
            accountsRepository.fetchAccounts({
                (accounts, error) -> Void in
                asyncService.performOnMainQueue() {
                    if let tableView = self.tableView {
                        self.accounts = accounts
                        tableView.reloadData()
                    }
                }
            })
        }
    }
}

extension AccountsViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier("AccountCell", forIndexPath: indexPath)
    }
}

extension AccountsViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let accountCell = cell as! AccountCell
        if let nameLabel = accountCell.nameLabel,
               balanceLabel = accountCell.balanceLabel
        {
            let account = self.accounts[indexPath.row]
            nameLabel.text = account.name
            balanceLabel.text = currencyFormatter.stringFromNumber(account.balance)
        }
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Accounts"
    }
}

extension AccountsViewController: LoginViewControllerDelegate {
    func loginViewControllerLoginSuccessful() {
        self.dismissViewControllerAnimated(true) {}
        self.fetchAndDisplayAccounts()
    }
}
