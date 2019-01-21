import Foundation
import ReSwift

extension Reducers {
    
    static func sessionReducer(action: Action, state: SessionState?) -> SessionState {
        var state = state ?? SessionState()
        state.inProgress = false
        
        switch action {
        case is SignInActions.SigningIn, is SignOutActions.SigningOut:
            state.inProgress = true
            
        case let action as SignInActions.SignedIn:
            state.token = action.token
            state.user = action.user
            
        case is SignOutActions.SignedOut:
            state.token = nil
            state.user = nil
            
        default:
            break
        }
        
        return state
    }
}
