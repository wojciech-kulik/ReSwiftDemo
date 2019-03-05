import Foundation
import ReSwift

protocol NetworkClient {
    func request(_ request: HttpRequest, dispatch: @escaping DispatchFunction)
}
