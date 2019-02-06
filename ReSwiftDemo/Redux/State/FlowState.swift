import Foundation
import ReSwift

struct FlowState: StateType, Equatable {
    private(set) var flow = Flow.splashScreen
}
