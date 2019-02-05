import Foundation
import ReSwift
import UIKit
import SwinjectStoryboard

class FlowManager: StoreSubscriber {
	
    private let store: Store<AppState>
    private let sessionManager: SessionManager
    
    init(store: Store<AppState>, sessionManager: SessionManager) {
        self.store = store
        self.sessionManager = sessionManager
        self.subscribe()
    }
    
    func subscribe() {
        self.store.subscribe(self) { subscription in
            subscription.select { state in state.flowState }.skipRepeats()
        }
    }
	
    func newState(state: FlowState) {
        print("Set Flow: \(state.flow)")
        
        if state.flow == .splashScreen {
            self.restoreState()
        } else if state.flow == .signIn {
            self.showScreen(name: "LoginViewController")
        } else if state.flow == .dashboard {
            self.showScreen(name: "MainViewController")
        }
    }
    
    func showScreen(name: String) {
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: AppDelegate.container)
        let rootController = storyboard.instantiateViewController(withIdentifier: name)
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = rootController
            window.makeKeyAndVisible()
        }
    }
    
    private func restoreState() {
        if let session = self.sessionManager.loadSession() {
            self.store.dispatch(SessionActions.SetSession(session: session))
        } else {
            self.store.dispatch(SessionActions.NoSession())
        }
    }
}
