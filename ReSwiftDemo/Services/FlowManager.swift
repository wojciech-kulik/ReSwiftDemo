import Foundation
import ReSwift
import UIKit
import SwinjectStoryboard

class FlowManager: StoreSubscriber {
	
    private let store: Store<AppState>
    private let appUserInteractions: AppUserInteractions
    
    init(store: Store<AppState>, appUserInteractions: AppUserInteractions) {
        self.store = store
        self.appUserInteractions = appUserInteractions
        self.subscribe()
    }
    
    func subscribe() {
        self.store.subscribe(self) { subscription in
            subscription.select { state in state.flowState }.skipRepeats()
        }
    }
	
    func newState(state: FlowState) {
        print("Set Flow: \(state.flow)")
        
        if state.flow == .splashScreen {
            self.appUserInteractions.launchApp()
        } else if state.flow == .signIn {
            self.showScreen(name: "LoginViewController")
        } else if state.flow == .dashboard {
            self.showScreen(name: "MainViewController")
        }
    }
    
    func showScreen(name: String) {
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: AppDelegate.container)
        let rootController = storyboard.instantiateViewController(withIdentifier: name)
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = rootController
            window.makeKeyAndVisible()
        }
    }
}
