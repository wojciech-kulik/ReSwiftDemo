import Foundation
import ReSwift

struct SessionState: StateType, Equatable {
    let session: Session?
    
    init() {
        self.session = nil
    }
    
    init(session: Session?) {
        self.session = session
    }
}
