import UIKit
import ReSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    var store: Store<AppState>!
    var sessionUserInteractions: SessionUserInteractions!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.store.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.store.unsubscribe(self)
    }

    @IBAction func loginClicked(_ sender: Any) {
        self.sessionUserInteractions.signIn(
            username: self.loginTextField.text ?? "",
            password: self.passwordTextField.text ?? "")
    }
}

// MARK: state management
extension LoginViewController: StoreSubscriber {
    
    func newState(state: AppState) {
        if state.sessionState.inProgress {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
        
        self.loginButton.isHidden = state.sessionState.inProgress
    }
}
