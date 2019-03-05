import Foundation
import ReSwift

protocol HttpRequest {
    var resource: String { get }
    var method: HttpMethod { get }
    var json: Data? { get }
    
    func onSuccess(response: Data?) -> [Action]
    func onFailure(response: Data?) -> [Action]
}
