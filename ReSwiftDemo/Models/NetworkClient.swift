import Foundation
import ReSwift

protocol NetworkClient {
    func request(_ request: RestRequest, dispatch: @escaping DispatchFunction)
}
