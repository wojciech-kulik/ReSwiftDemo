import Foundation
import Swinject
import SwinjectStoryboard
import ReSwift

extension Container {
	
    func registerDependencies() {
        self.registerRedux()
        self.registerUserInteractions()
        self.registerManagers()
        self.registerViewControllers()
    }
    
    private func registerRedux() {
        let store = Store(reducer: Reducers.appReducer, state: self.getInitialState(), middleware: [self.loggingMiddleware()])
        self.register(Store.self) { _ in store }.inObjectScope(.container)
        self.register(DispatchingStoreType.self) { _ in store }.inObjectScope(.container)
    }
	
    private func registerUserInteractions() {
        self.autoregister(SessionUserInteractions.self, initializer: SessionUserInteractions.init).inObjectScope(.container)
        self.autoregister(AppUserInteractions.self, initializer: AppUserInteractions.init).inObjectScope(.container)
    }
    
    private func registerManagers() {
        self.autoregister(SessionManager.self, initializer: SessionManager.init).inObjectScope(.container)
        self.autoregister(FlowManager.self, initializer: FlowManager.init).inObjectScope(.container)
    }
    
    private func registerViewControllers() {
        self.storyboardInitCompleted(MainViewController.self) { resolver, viewController in
            viewController.store = resolver.resolve(Store<AppState>.self)
            viewController.sessionUserInteractions = resolver.resolve(SessionUserInteractions.self)
        }
        
        self.storyboardInitCompleted(LoginViewController.self) { resolver, viewController in
            viewController.store = resolver.resolve(Store<AppState>.self)
            viewController.sessionUserInteractions = resolver.resolve(SessionUserInteractions.self)
        }
    }
    
    private func getInitialState() -> AppState {
        return AppState(
            flowState: FlowState(flow: .splashScreen),
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
