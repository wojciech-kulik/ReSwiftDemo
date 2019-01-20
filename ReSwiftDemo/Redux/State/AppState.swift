import Foundation
import ReSwift

struct AppState: StateType {
    let navigationState: NavigationState
    let sessionState: SessionState
}
