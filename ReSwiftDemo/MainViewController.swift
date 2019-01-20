import Foundation
import UIKit
import ReSwift

class MainViewController: UIViewController {
	
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logOutButton: UIButton!
    
    let store: Store<AppState> = AppDelegate.container.resolve(Store<AppState>.self)!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.store.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.store.unsubscribe(self)
    }
    
    func signOutActionCreator(state: AppState, store: Store<AppState>) -> Action? {
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) { [weak self] in
            self?.store.dispatch(SignedOutSuccessfullyAction())
        }
        return SigningOutProgressAction()
    }
	
    @IBAction func logOutClicked(_ sender: Any) {
        self.store.dispatch(self.signOutActionCreator)
    }
}


extension MainViewController: StoreSubscriber {
    
    func newState(state: AppState) {
        if state.sessionState.inProgress {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
        
        self.logOutButton.isHidden = state.sessionState.inProgress
        self.usernameLabel.text = state.sessionState.token
    }
}
