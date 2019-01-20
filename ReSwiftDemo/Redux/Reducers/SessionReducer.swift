import Foundation
import ReSwift

extension Reducers {
    
    static func sessionReducer(action: Action, state: SessionState?) -> SessionState {
        var state = state ?? SessionState()
        state.inProgress = false
        
        switch action {
        case is SigningInProgressAction, is SigningOutProgressAction:
            state.inProgress = true
            
        case let action as SignedInSuccessfullyAction:
            state.authenticated = true
            state.token = action.token
            
        case let action as SessionRestoredAction:
            state.authenticated = true
            state.token = action.token
            
        case is SignedOutSuccessfullyAction:
            state.authenticated = false
            state.token = nil
            
        default:
            break
        }
        
        return state
    }
}
