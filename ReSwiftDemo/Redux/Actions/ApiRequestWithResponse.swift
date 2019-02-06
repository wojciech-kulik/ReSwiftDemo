import Foundation
import ReSwift

protocol ApiRequestWithResponse: ApiRequest {
    associatedtype Response
    var onSuccess: (Response) -> [Action] { get }
}
