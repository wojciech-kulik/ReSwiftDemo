import Foundation
import ReSwift

extension Middlewares {
    
    static func getAuthMiddleware() -> Middleware<AppState> {
        return { dispatch, getState in
            return { next in
                return { action in
                    next(action)
                    
                    switch action {
                    case is RestoreState:
                        if let session = loadSession() {
                            dispatch(SessionActions.SetSession(session: session))
                        } else {
                            dispatch(SessionActions.NoSession())
                        }
                    
                    case let action as SessionActions.SetSession:
                        saveSession(session: action.session)
                        
                    case is SessionActions.NoSession:
                        removeSession()
                        
                    default:
                        return
                    }
                }
            }
        }
    }
    
    private static func loadSession() -> Session? {
        if let data = UserDefaults.standard.value(forKey: "session") as? Data {
            return try? JSONDecoder().decode(Session.self, from: data)
        }
        
        return nil
    }
    
    private static func saveSession(session: Session) {
        // warning: if you quickly terminate app after these operations, UserDefaults might not be up to date
        UserDefaults.standard.set(try? JSONEncoder().encode(session), forKey: "session")
        print("SESSION SET")
    }
    
    private static func removeSession() {
        UserDefaults.standard.removeObject(forKey: "session")
        print("SESSION REMOVED")
    }
}
