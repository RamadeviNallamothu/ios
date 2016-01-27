import Foundation

class Account {
    var name: String = ""
    var type: String = ""
    var balance: Float = 0.0

    init(name: String, type: String, balance: Float) {
        self.name = name
        self.type = type
        self.balance = balance
    }
}

extension Account: Equatable {}

func ==(lhs: Account, rhs: Account) -> Bool {
    return lhs.name == rhs.name && lhs.type == rhs.type && lhs.balance == rhs.balance
}
