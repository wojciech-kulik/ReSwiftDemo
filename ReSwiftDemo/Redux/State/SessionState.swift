import Foundation
import ReSwift

struct SessionState: StateType {
    var authenticated = false
    var inProgress = false
    var token: String?
}
