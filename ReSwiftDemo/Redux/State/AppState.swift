import Foundation
import ReSwift

struct AppState: StateType, Equatable {
    let flowState: FlowState
    let sessionState: SessionState
    let error: ErrorMessage?
    
    init() {
        self.flowState = FlowState()
        self.sessionState = SessionState()
        self.error = nil
    }
    
    init(flowState: FlowState, sessionState: SessionState, error: ErrorMessage?) {
        self.flowState = flowState
        self.sessionState = sessionState
        self.error = error
    }
}
