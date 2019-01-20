import Foundation
import ReSwift

struct Reducers {
    private init() {
    }
    
    static func appReducer(action: Action, state: AppState?) -> AppState {
        return AppState(
            navigationState: Reducers.navigationReducer(action: action, state: state?.navigationState),
            sessionState: Reducers.sessionReducer(action: action, state: state?.sessionState)
        )
    }
}
