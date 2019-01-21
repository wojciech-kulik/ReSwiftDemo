import UIKit
import Swinject
import SwinjectAutoregistration

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var flowManager: FlowManager?
    static let container = Container()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AppDelegate.container.registerDependencies()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.flowManager = AppDelegate.container.resolve(FlowManager.self)
        AppDelegate.container.resolve(AppUserInteractions.self)?.launchApp()
        
        return true
    }
}
