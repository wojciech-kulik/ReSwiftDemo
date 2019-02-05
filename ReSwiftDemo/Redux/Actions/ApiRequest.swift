import Foundation
import ReSwift

protocol ApiRequest: Action {
    var onSuccess: (Any?) -> [Action] { get }
}
