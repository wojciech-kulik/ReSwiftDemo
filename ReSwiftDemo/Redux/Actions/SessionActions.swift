import Foundation
import ReSwift

enum SessionActions {
    
    struct NoSession: Action { }
    
    struct SetSession: Action {
        let session: Session
    }
    
    struct SignIn: ApiRequestWithResponse {
        let credentials: Credentials
        let onSuccess: (Session) -> [Action] = { [SetSession(session: $0)] }
    }
    
    struct SignOut: ApiRequestNoResponse {
        let onSuccess: () -> [Action] = { [NoSession()] }
    }
}
