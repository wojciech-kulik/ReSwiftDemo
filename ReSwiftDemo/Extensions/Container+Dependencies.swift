import Foundation
import Swinject
import SwinjectStoryboard
import ReSwift

extension Container {
	
    func registerDependencies() {
        self.registerRedux()
        self.registerManagers()
        self.registerViewControllers()
    }
    
    private func registerRedux() {
        let store = Store(reducer: Reducers.appReducer, state: AppState(), middleware: Middlewares.all)
        self.register(Store.self) { _ in store }.inObjectScope(.container)
        self.register(DispatchingStoreType.self) { _ in store }.inObjectScope(.container)
    }
    
    private func registerManagers() {
        self.autoregister(FlowManager.self, initializer: FlowManager.init).inObjectScope(.container)
        
        #warning("You can replace this mocked implementation with real one")
        // Check out sample implementation in SampleRestClient.swift
        // self.register(NetworkClient.self) { resolver in SampleRestClient(serverUrl: "https://localhost" )}.inObjectScope(.container)
        self.autoregister(NetworkClient.self, initializer: FakeRestClient.init).inObjectScope(.container)
    }
    
    private func registerViewControllers() {
        self.storyboardInitCompleted(MainViewController.self) { resolver, viewController in
            viewController.store = resolver.resolve(Store<AppState>.self)
        }
        
        self.storyboardInitCompleted(LoginViewController.self) { resolver, viewController in
            viewController.store = resolver.resolve(Store<AppState>.self)
        }
    }
}
