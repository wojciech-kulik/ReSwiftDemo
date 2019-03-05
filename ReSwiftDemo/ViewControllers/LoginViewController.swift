import UIKit
import ReSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    var store: Store<AppState>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.store.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.store.unsubscribe(self)
    }

    @IBAction func loginClicked(_ sender: Any) {
        self.set(inProgress: true)
        
        let credentials = Credentials(
            username: self.loginTextField.text ?? "",
            password: self.passwordTextField.text ?? "")
        self.store.dispatch(SessionActions.SignIn(credentials: credentials))
    }
    
    private func set(inProgress: Bool) {
        inProgress
            ? self.activityIndicator.startAnimating()
            : self.activityIndicator.stopAnimating()
        
        self.loginButton.isHidden = inProgress
        self.loginTextField.isEnabled = !inProgress
        self.passwordTextField.isEnabled = !inProgress
    }
}

// MARK: state management
extension LoginViewController: StoreSubscriber {
    
    func newState(state: AppState) {
        if let error = state.error {
            self.set(inProgress: false)
            self.display(error: error) {
                self.store.dispatch(AlertActions.ErrorDismissed(error: error))
            }
        }
    }
}
