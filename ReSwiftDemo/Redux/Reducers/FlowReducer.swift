import Foundation
import ReSwift

extension Reducers {
    
    static func flowReducer(action: Action, state: FlowState?) -> FlowState {
        var state = state ?? FlowState(flow: .splashScreen)
        
        switch action {
        case is SignInActions.SignedIn:
            state.flow = .dashboard
            
        case is SignInActions.NoSession, is SignOutActions.SignedOut:
            state.flow = .signIn
            
        default:
            break
        }
        
        return state
    }
}
