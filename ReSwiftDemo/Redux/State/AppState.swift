import Foundation
import ReSwift

struct AppState: StateType, Equatable {
    let flowState: FlowState
    let sessionState: SessionState
}
