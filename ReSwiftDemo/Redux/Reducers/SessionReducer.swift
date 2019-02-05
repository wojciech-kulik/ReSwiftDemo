import Foundation
import ReSwift

extension Reducers {
    
    static func sessionReducer(action: Action, state: SessionState?) -> SessionState {
        
        switch action {
        case let action as SessionActions.SetSession:
            return SessionState(session: action.session)
            
        case is SessionActions.NoSession:
            return SessionState(session: nil)
            
        default:
            return state ?? SessionState()
        }
    }
}
