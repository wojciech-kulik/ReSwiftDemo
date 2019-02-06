import Foundation
import ReSwift

struct SessionState: StateType, Equatable {
    private(set) var session: Session?
}
