import Foundation
import ReSwift

extension Reducers {
    
    static func navigationReducer(action: Action, state: NavigationState?) -> NavigationState {
        var state = state ?? NavigationState(screen: .launching)
        
        switch action {
        case is SignInActions.SignedIn:
            state.screen = .dashboard
            
        case is SignInActions.NoSession, is SignOutActions.SignedOut:
            state.screen = .signIn
            
        default:
            break
        }
        
        return state
    }
}
