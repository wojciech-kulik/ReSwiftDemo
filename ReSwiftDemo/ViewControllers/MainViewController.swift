import Foundation
import UIKit
import ReSwift

class MainViewController: UIViewController {
	
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logOutButton: UIButton!
    
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
    
    @IBAction func logOutClicked(_ sender: Any) {
        self.sessionUserInteractions.signOut()
    }
}

// MARK: state management
extension MainViewController: StoreSubscriber {
    
    func newState(state: AppState) {
        if state.sessionState.inProgress {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
        
        self.logOutButton.isHidden = state.sessionState.inProgress
        
        if let user = state.sessionState.user {
            self.usernameLabel.text = user.firstName + " " + user.lastName
            self.infoLabel.text = "token: \(state.sessionState.token ?? "n/a")"
        }
    }
}
