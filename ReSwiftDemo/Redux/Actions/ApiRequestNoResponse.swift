import Foundation
import ReSwift

protocol ApiRequestNoResponse: ApiRequest {
    var onSuccess: () -> [Action] { get }
}
