import Foundation

class AccountPresenter {
    let currencyFormatter = NSNumberFormatter()

    init() {
        currencyFormatter.numberStyle = .CurrencyStyle
    }

    func formattedName(account: Account) -> String {
        return account.name.uppercaseString
    }

    func formmattedBalance(account: Account) -> String {
        return currencyFormatter.stringFromNumber(account.balance)!
    }
}