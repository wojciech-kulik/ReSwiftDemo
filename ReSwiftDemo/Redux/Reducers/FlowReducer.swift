import Foundation
import ReSwift

extension Reducers {
    
    static func flowReducer(action: Action, state: FlowState?) -> FlowState {
        
        switch action {
        case is SessionActions.SetSession:
            return FlowState(flow: .dashboard)
            
        case is SessionActions.NoSession:
            return FlowState(flow: .signIn)
            
        default:
            return state ?? FlowState()
        }
    }
}
