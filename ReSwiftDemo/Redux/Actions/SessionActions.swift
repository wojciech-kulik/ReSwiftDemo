import Foundation
import ReSwift

enum SessionActions {
    
    struct NoSession: Action { }
    
    struct SetSession: Action {
        let session: Session
    }
    
    struct SignIn: ApiRequest {
        let credentials: Credentials
        let onSuccess: (Any?) -> [Action] = { session in
            guard let session = session as? Session else { return [] }
            return [SetSession(session: session)]
        }
        
    }
    
    struct SignOut: ApiRequest {
        let onSuccess: (Any?) -> [Action] = { _ in [NoSession()] }
    }
}
