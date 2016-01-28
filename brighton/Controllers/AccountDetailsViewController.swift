
import UIKit

class AccountDetailsViewController : UIViewController {
    private(set) var account: Account?
    let accountPresenter = AccountPresenter()

    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var balancelabel: UILabel?

    func configure(account: Account){
        self.account = account
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let account = self.account,
               nameLabel = nameLabel,
               balancelabel = balancelabel
        {
            nameLabel.text = accountPresenter.formattedName(account)
            balancelabel.text = accountPresenter.formmattedBalance(account)
        }
    }
}
