import Foundation
import ReSwift

struct SignInActions {
    
    struct NoSession: Action { }
    
    struct SigningIn: Action { }
    
    struct SignInFailed: Action {
        let error: String
    }
    
    struct DismissedError: Action { }
    
    struct SignedIn: Action {
        let token: String
        let user: User
    }
}
