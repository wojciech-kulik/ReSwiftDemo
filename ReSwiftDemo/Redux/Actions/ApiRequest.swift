import Foundation
import ReSwift

// For requests which does not return any payload
struct VoidResponse: Codable { }

class ApiRequest<T:Codable>: Action, RestRequest {
    let resource: String
    let method: HttpMethod
    let json: Data?
    
    init(resource: String, method: HttpMethod, json: Data? = nil) {
        self.resource = resource
        self.method = method
        self.json = json
    }

    func onSuccess(response: T) -> [Action] {
        return []
    }
    
    func onFailure(response: ErrorResponse) -> [Action] {
        return [AlertActions.DisplayError(title: "Error", message: response.message, buttons: ["OK"])]
    }
    
    // MARK: RestRequest
    func onSuccess(response: Data?) -> [Action] {
        if let response = response?.toObject(T.self) {
            return self.onSuccess(response: response)
        }
        
        return []
    }
    
    func onFailure(response: Data?) -> [Action] {
        if let error = response?.toObject(ErrorResponse.self) {
            return self.onFailure(response: error)
        }
        
        return [AlertActions.DisplayError(title: "Error",
                                          message: "Something went wrong. Please check your internet connection.",
                                          buttons: ["OK"])]
    }
}
