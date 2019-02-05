import Foundation
import ReSwift

struct FlowState: StateType, Equatable {
    let flow: Flow
    
    init() {
        self.flow = .splashScreen
    }
    
    init(flow: Flow) {
        self.flow = flow
    }
}
