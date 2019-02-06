import Foundation
import ReSwift

struct AppState: StateType, Equatable {
    private(set) var flowState = FlowState()
    private(set) var sessionState = SessionState()
    private(set) var error: ErrorMessage?
}
