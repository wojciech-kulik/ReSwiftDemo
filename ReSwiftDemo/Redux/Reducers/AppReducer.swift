import Foundation
import ReSwift

struct Reducers {
    private init() {
    }
    
    static func appReducer(action: Action, state: AppState?) -> AppState {
        return AppState(
            flowState: Reducers.flowReducer(action: action, state: state?.flowState),
            sessionState: Reducers.sessionReducer(action: action, state: state?.sessionState)
        )
    }
}
