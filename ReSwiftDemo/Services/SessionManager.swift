import Foundation
import ReSwift

class SessionManager: StoreSubscriber {
    
    private let store: Store<AppState>
    private var session: Session?
	
    init(store: Store<AppState>) {
        self.store = store
        self.store.subscribe(self)
    }
    
    func loadSession() -> Session? {
        if let data = UserDefaults.standard.value(forKey: "session") as? Data {
            return try? PropertyListDecoder().decode(Session.self, from: data)
        }
        
        return nil
    }
    
    func newState(state: AppState) {
        guard state.flowState.flow != .splashScreen else { return }
        guard self.session != state.sessionState.session else { return }
        
        // warning: if you quickly terminate app after these operations, UserDefaults might not be up to date
        
        if state.sessionState.session != nil {
            self.session = state.sessionState.session
            UserDefaults.standard.set(try? PropertyListEncoder().encode(state.sessionState.session), forKey: "session")
            print("SESSION SET")
        } else {
            self.session = nil
            UserDefaults.standard.removeObject(forKey: "session")
            print("SESSION REMOVED")
        }
    }
}
