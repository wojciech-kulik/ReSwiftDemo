import Foundation
import ReSwift

struct SessionState: StateType, Equatable {
    var inProgress = false
    var token: String?
    var user: User?
}
