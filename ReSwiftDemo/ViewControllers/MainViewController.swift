import Foundation
import UIKit
import ReSwift

class MainViewController: UIViewController {
	
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logOutButton: UIButton!
    
    var store: Store<AppState>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.store.subscribe(self) { subscription in
            subscription.select { $0.sessionState }.skipRepeats()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.store.unsubscribe(self)
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        self.set(inProgress: true)
        self.store.dispatch(SessionActions.SignOut())
    }
    
    private func set(inProgress: Bool) {
        inProgress
            ? self.activityIndicator.startAnimating()
            : self.activityIndicator.stopAnimating()
        
        self.logOutButton.isHidden = inProgress
    }
}

// MARK: state management
extension MainViewController: StoreSubscriber {
    func newState(state: SessionState) {
        if let session = state.session {
            self.usernameLabel.text = session.firstName + " " + session.lastName
            self.infoLabel.text = "token: \(session.token)"
        }
    }
}
