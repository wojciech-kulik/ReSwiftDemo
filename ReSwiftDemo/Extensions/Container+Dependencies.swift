import Foundation
import Swinject
import ReSwift

extension Container {
	
    func registerDependencies() {
        self.registerRedux()
        self.registerUserInteractions()
        self.registerManagers()
    }
    
    private func registerRedux() {
        let store = Store(reducer: Reducers.appReducer, state: self.getInitialState(), middleware: [self.loggingMiddleware()])
        AppDelegate.container.register(Store.self) { _ in store }.inObjectScope(.container)
        AppDelegate.container.register(DispatchingStoreType.self) { _ in store }.inObjectScope(.container)
    }
	
    private func registerUserInteractions() {
        AppDelegate.container.autoregister(SessionUserInteractions.self, initializer: SessionUserInteractions.init).inObjectScope(.container)
        AppDelegate.container.autoregister(AppUserInteractions.self, initializer: AppUserInteractions.init).inObjectScope(.container)
    }
    
    private func registerManagers() {
        AppDelegate.container.autoregister(SessionManager.self, initializer: SessionManager.init).inObjectScope(.container)
    }
    
    private func getInitialState() -> AppState {
        return AppState(
            navigationState: NavigationState(screen: .launching),
            sessionState: SessionState()
        )
    }
    
    private func loggingMiddleware() -> Middleware<Any> {
        return { dispatch, getState in
            return { next in
                return { action in
                    // perform middleware logic
                    print(action)
                    
                    // call next middleware
                    return next(action)
                }
            }
        }
    }
}
