import Foundation
import ReSwift

struct SignOutActions {
    
    struct SigningOut: Action { }
    
    struct SignOutFailed: Action {
        let error: String
    }
    
    struct DismissedError: Action { }
    
    struct SignedOut: Action { }
}
