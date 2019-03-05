import Foundation
import ReSwift

extension UIViewController {
	
    func display(error: ErrorMessage, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        
        for button in error.buttons {
            let alertAction = UIAlertAction(title: button, style: .default) { _ in
                completion()
            }
            
            alert.addAction(alertAction)
        }
        
        self.present(alert, animated: true)
    }
}
