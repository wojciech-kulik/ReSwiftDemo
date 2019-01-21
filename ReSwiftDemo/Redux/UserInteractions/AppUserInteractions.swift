import Foundation
import ReSwift

class AppUserInteractions {
    
    let dispatcher: DispatchingStoreType
    let sessionManager: SessionManager
    
    init(dispatcher: DispatchingStoreType, sessionManager: SessionManager) {
        self.dispatcher = dispatcher
        self.sessionManager = sessionManager
    }
    
    func launchApp() {
        if let (token, user) = self.sessionManager.loadSession() {
            self.dispatcher.dispatch(SignInActions.SignedIn(token: token, user: user))
        } else {
            self.dispatcher.dispatch(SignInActions.NoSession())
        }
    }
}
