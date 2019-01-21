import Foundation
import ReSwift

class SessionUserInteractions {
    
    let dispatcher: DispatchingStoreType
    
    init(dispatcher: DispatchingStoreType) {
        self.dispatcher = dispatcher
    }
    
    func signIn(username: String, password: String) {
        self.dispatcher.dispatch(SignInActions.SigningIn())
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) { [weak self] in
            if username != "" && username == password {
                self?.dispatcher.dispatch(
                    SignInActions.SignedIn(token: "12356sadas123", user: User(firstName: "John", lastName: "Snow")))
            } else {
                self?.dispatcher.dispatch(
                    SignInActions.SignInFailed(error: ErrorMessage(title: "Error", message: "Invalid credentials")))
            }
        }
    }
    
    func signOut() {
        self.dispatcher.dispatch(SignOutActions.SigningOut())
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) { [weak self] in
            self?.dispatcher.dispatch(SignOutActions.SignedOut())
        }
    }
}
