import Foundation
import ReSwift

class SessionManager: StoreSubscriber {
    
    private let store: Store<AppState>
    private var token: String?
	
    init(store: Store<AppState>) {
        self.store = store
        self.store.subscribe(self)
    }
    
    func loadSession() -> (String, User)? {
        self.token = UserDefaults.standard.string(forKey: "token")
        
        if let token = self.token,
            let data = UserDefaults.standard.value(forKey: "user") as? Data,
            let user = try? PropertyListDecoder().decode(User.self, from: data) {
            
            return (token, user)
        }
        
        return nil
    }
    
    func newState(state: AppState) {
        guard state.flowState.flow != .splashScreen else { return }
        guard self.token != state.sessionState.token else { return }
        
        // warning: if you quickly terminate app after these operations, UserDefaults might not be up to date
        
        if state.sessionState.token != nil {
            self.token = state.sessionState.token
            UserDefaults.standard.set(state.sessionState.token, forKey: "token")
            UserDefaults.standard.set(try? PropertyListEncoder().encode(state.sessionState.user), forKey: "user")
            print("SESSION SET")
        } else {
            self.token = nil
            UserDefaults.standard.removeObject(forKey: "token")
            UserDefaults.standard.removeObject(forKey: "user")
            print("SESSION REMOVED")
        }
    }
}
