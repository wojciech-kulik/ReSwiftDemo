import Foundation
import ReSwift

extension Middlewares {
	
    static func getApiMiddleware() -> Middleware<AppState> {
        return { dispatch, getState in
            return { next in
                return { action in
                    next(action)
                    
                    guard let apiRequest = action as? ApiRequest else { return }
                    
                    // FAKE BACKEND SIMULATION
                    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
                        switch apiRequest {
                        case let signInAction as SessionActions.SignIn:
                            let username = signInAction.credentials.username
                            let password = signInAction.credentials.password
                            
                            if username != "" && username == password {
                                let session = Session(token: "12356sadas123", firstName: "John", lastName: "Snow")
                                signInAction.onSuccess(session).forEach(dispatch)
                            } else {
                                let error = ApiRequestError(
                                    apiRequest: apiRequest,
                                    error: ErrorMessage(title: "Error", message: "Invalid credentials"))
                                dispatch(error)
                            }
                            
                        case let signOutAction as SessionActions.SignOut:
                            signOutAction.onSuccess().forEach(dispatch)
                            
                        default:
                            break
                        }
                    }
                }
            }
        }
    }
}
