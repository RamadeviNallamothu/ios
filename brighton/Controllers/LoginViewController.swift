import UIKit

protocol LoginViewControllerDelegate {
    func loginViewControllerLoginSuccessful() -> Void
}

class LoginViewController: UIViewController {
    var requestFactory: RequestFactoryProtocol?
    var urlSession: URLSessionProtocol?
    var delegate: LoginViewControllerDelegate?

    @IBOutlet weak var usernameTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var submitButton: UIButton?

    func configure(delegate: LoginViewControllerDelegate) {
        self.configure(requestFactory: RequestFactory(), urlSession: NSURLSession.sharedSession(), delegate: delegate)
    }

    func configure(requestFactory requestFactory: RequestFactoryProtocol, urlSession: URLSessionProtocol, delegate: LoginViewControllerDelegate) {
        self.requestFactory = requestFactory
        self.urlSession = urlSession
        self.delegate = delegate
    }

    @IBAction
    func submitButtonTapped() {
        if let requestFactory = requestFactory,
               urlSession = urlSession,
               usernameTextField = usernameTextField,
               username = usernameTextField.text,
               passwordTextField = passwordTextField,
               password = passwordTextField.text
        {
            let task = urlSession.dataTaskWithRequest(requestFactory.requestForLogin(username: username, password: password)) {
                (data, response, error) -> Void in
                if let response = response,
                       delegate = self.delegate
                {
                    let httpResponse = response as! NSHTTPURLResponse
                    if (httpResponse.statusCode == 200) {
                        delegate.loginViewControllerLoginSuccessful()
                    }
                }
            }
            task.resume()
        }
    }

}
