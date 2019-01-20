import Foundation
import ReSwift

class SessionManager: StoreSubscriber {
    
    let store: Store<AppState>
    var authenticated = false
	
    init(store: Store<AppState>) {
        self.store = store
        self.store.subscribe(self)
    }
    
    func newState(state: AppState) {
        if state.navigationState.screen == .launching {
            if let token = UserDefaults.standard.string(forKey: "token") {
                store.dispatch(SessionRestoredAction(token: token))
            } else {
                store.dispatch(EmptySessionAction())
            }
        } else if self.authenticated != state.sessionState.authenticated {
            self.authenticated = state.sessionState.authenticated
            
            if self.authenticated {
                UserDefaults.standard.set(state.sessionState.token, forKey: "token")
                UserDefaults.standard.synchronize()
            } else {
                UserDefaults.standard.removeObject(forKey: "token")
            }
        }
    }
}
