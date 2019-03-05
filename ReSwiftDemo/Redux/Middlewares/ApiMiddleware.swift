import Foundation
import ReSwift

extension Middlewares {
	
    static func getApiMiddleware() -> Middleware<AppState> {
        return { dispatch, getState in
            return { next in
                return { action in
                    next(action)
                    
                    guard let request = action as? HttpRequest else { return }
                    restClient.request(request, dispatch: dispatch)
                }
            }
        }
    }
}
