import UIKit
import ReSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    let store: Store<AppState> = AppDelegate.container.resolve(Store<AppState>.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.store.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.store.unsubscribe(self)
    }
    
    func signInActionCreator(state: AppState, store: Store<AppState>) -> Action? {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) { [weak self] in
            self?.store.dispatch(SignedInSuccessfullyAction(token: "12356sadas123"))
        }
        return SigningInProgressAction()
    }

    @IBAction func loginClicked(_ sender: Any) {
        self.store.dispatch(self.signInActionCreator)
    }
}


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
