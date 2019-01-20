import UIKit
import Swinject
import SwinjectAutoregistration
import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, StoreSubscriber {

    var window: UIWindow?
    var screen: Screen?
    var sessionManager: SessionManager?
    static let container = Container()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        AppDelegate.container.register(Store.self) { _ in Store( reducer: Reducers.appReducer, state: self.getInitialState()) }.inObjectScope(.container)
        AppDelegate.container.autoregister(SessionManager.self, initializer: SessionManager.init).inObjectScope(.container)
        
        self.sessionManager = AppDelegate.container.resolve(SessionManager.self)
        
        if let store = AppDelegate.container.resolve(Store<AppState>.self) {
            store.subscribe(self) { subscription in
                subscription.select { state in state.navigationState }
            }
        }

        return true
    }
    
    func newState(state: NavigationState) {
        guard screen != state.screen else { return }
        self.screen = state.screen

        if state.screen == .signIn {
            self.showLoginScreen()
        } else if state.screen == .dashboard {
            self.showDashboard()
        }
    }
    
    func showLoginScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        
        if let window = self.window {
            window.rootViewController = rootController
            window.makeKeyAndVisible()
        }
    }
    
    func showDashboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        
        if let window = self.window {
            window.rootViewController = rootController
            window.makeKeyAndVisible()
        }
    }
    
    func getInitialState() -> AppState {
        return AppState(
            navigationState: NavigationState(screen: .launching),
            sessionState: SessionState()
        )
    }
}

