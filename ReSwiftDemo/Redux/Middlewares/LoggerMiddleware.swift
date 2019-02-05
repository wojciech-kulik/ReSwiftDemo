import Foundation
import ReSwift

extension Middlewares {
    
    static func getLoggerMiddleware() -> Middleware<AppState> {
        return { dispatch, getState in
            return { next in
                return { action in
                    print(String(describing: action))
                    return next(action)
                }
            }
        }
    }
}
