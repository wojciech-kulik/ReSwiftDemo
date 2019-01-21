import Foundation
import ReSwift

struct AppState: StateType, Equatable {
    let navigationState: NavigationState
    let sessionState: SessionState
}
