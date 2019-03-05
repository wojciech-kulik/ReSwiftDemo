import Foundation
import ReSwift

class FakeRestClient: NetworkClient {
	
    func request(_ request: RestRequest, dispatch: @escaping DispatchFunction) {
        
        // BACKEND SIMULATION
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            if request.resource == "api/login" {
                let credentials = request.json?.toObject(Credentials.self)
                let username = credentials?.username
                let password = credentials?.password
                
                if username != "" && username == password {
                    let session = Session(token: "12356sadas123", firstName: "John", lastName: "Snow").toJson()
                    request.onSuccess(response: session).forEach(dispatch)
                } else {
                    let error = ErrorResponse(message: "Invalid credentials", code: 401).toJson()
                    request.onFailure(response: error).forEach(dispatch)
                }
            } else if request.resource == "api/logout" {
                request.onSuccess(response: VoidResponse().toJson()).forEach(dispatch)
            }
        }
    }
}
