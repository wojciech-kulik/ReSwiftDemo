import Foundation
import ReSwift

struct ApiRequestError: Action {
    let apiRequest: ApiRequest
    let error: ErrorMessage
}
