import UIKit
import Swinject
import SwinjectAutoregistration
import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var screen: Screen?
    static let container = Container()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppDelegate.container.registerDependencies()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.subscribe()
        self.dispatchLaunchApp()
        return true
    }
}

// MARK: State management
extension AppDelegate: StoreSubscriber {
    
    func subscribe() {
        AppDelegate.container.resolve(Store<AppState>.self)?.subscribe(self) { subscription in
            subscription.select { state in state.navigationState }.skipRepeats()
        }
    }
    
    func dispatchLaunchApp() {
        AppDelegate.container.resolve(AppUserInteractions.self)?.launchApp()
    }
    
    func newState(state: NavigationState) {
        guard screen != state.screen else { return }
        self.screen = state.screen
        
        if state.screen == .signIn {
            self.showScreen(name: "LoginViewController")
        } else if state.screen == .dashboard {
            self.showScreen(name: "MainViewController")
        }
    }
    
    func showScreen(name: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootController = storyboard.instantiateViewController(withIdentifier: name)
        
        if let window = self.window {
            window.rootViewController = rootController
            window.makeKeyAndVisible()
        }
    }
}
