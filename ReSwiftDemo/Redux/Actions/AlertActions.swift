import Foundation
import ReSwift

enum AlertActions {
	
    struct ErrorDismissed: Action {
        let error: ErrorMessage
    }
    
    struct DisplayError: Action {
        let error: ErrorMessage
        
        init(title: String, message: String, buttons: [String]) {
            self.error = ErrorMessage(title: title, message: message, buttons: buttons)
        }
    }
}
