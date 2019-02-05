import Foundation
import ReSwift

enum Reducers {
    
    static func appReducer(action: Action, state: AppState?) -> AppState {
        var error = (action as? ApiRequestError)?.error ?? state?.error
        
        if action is AlertActions.ErrorDismissed {
            error = nil
        }
        
        return AppState(
            flowState: Reducers.flowReducer(action: action, state: state?.flowState),
            sessionState: Reducers.sessionReducer(action: action, state: state?.sessionState),
            error: error
        )
    }
}
