import UIKit

protocol LoginViewControllerDelegate {
    func loginViewControllerLoginSuccessful() -> Void
}

class LoginViewController: UIViewController {
    var authenticationRepository: AuthenticationRepositoryProtocol? = AuthenticationRepository()
    var delegate: LoginViewControllerDelegate?

    @IBOutlet weak var usernameTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var submitButton: UIButton?

    func configure(delegate: LoginViewControllerDelegate) {
        self.configure(authenticationRepository: AuthenticationRepository(), delegate: delegate)
    }

    func configure(authenticationRepository authenticationRepository: AuthenticationRepositoryProtocol, delegate: LoginViewControllerDelegate) {
        self.authenticationRepository = authenticationRepository
        self.delegate = delegate
    }

    @IBAction
    func submitButtonTapped() {
        if let authenticationRepository = authenticationRepository,
               usernameTextField = usernameTextField,
               username = usernameTextField.text,
               passwordTextField = passwordTextField,
               password = passwordTextField.text
        {
            authenticationRepository.login(username: username, password: password) {
                (error) -> Void in
                if let error = error {
                    print(error)
                } else if let delegate = self.delegate {
                    delegate.loginViewControllerLoginSuccessful()
                }
            }
        }
    }

}
