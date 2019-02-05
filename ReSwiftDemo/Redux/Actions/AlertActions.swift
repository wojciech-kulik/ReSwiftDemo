import Foundation
import ReSwift

enum AlertActions {
	
    struct ErrorDismissed : Action {
        let error: ErrorMessage
    }
}
