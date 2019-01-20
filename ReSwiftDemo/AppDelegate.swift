import UIKit
import Swinject
import SwinjectAutoregistration
import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let container = Container()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        container.register(Store.self) { _ in Store( reducer: appReducer, state: AppState()) }.inObjectScope(.container)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // get your storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // instantiate your desired ViewController
        let rootController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        
        // Because self.window is an optional you should check it's value first and assign your rootViewController
        if let window = self.window {
            window.rootViewController = rootController
            window.makeKeyAndVisible()
        }
        
        return true
    }
}

