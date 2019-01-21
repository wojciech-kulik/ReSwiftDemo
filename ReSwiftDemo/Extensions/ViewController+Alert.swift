import Foundation
import ReSwift

extension UIViewController {
	
    func displayError(title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion()
        }
        
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
}
