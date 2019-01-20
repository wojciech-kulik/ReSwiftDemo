import Foundation
import ReSwift

extension Reducers {
    
    static func navigationReducer(action: Action, state: NavigationState?) -> NavigationState {
        var state = state ?? NavigationState(screen: .launching)
        
        switch action {
        case is SignedInSuccessfullyAction, is SessionRestoredAction:
            state.screen = .dashboard
            
        case is EmptySessionAction, is SignedOutSuccessfullyAction:
            state.screen = .signIn
            
        default:
            break
        }
        
        return state
    }
}
