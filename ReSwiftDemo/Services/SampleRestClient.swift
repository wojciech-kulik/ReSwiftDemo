import Foundation
import ReSwift

class SampleRestClient: NetworkClient {
    
    let serverUrl: String
    
    init(serverUrl: String) {
        self.serverUrl = serverUrl.trimmingCharacters(in: ["/"])
    }
    
    func request(_ request: HttpRequest, dispatch: @escaping DispatchFunction) {
        
        guard let url = URL(string: "\(self.serverUrl)/\(request.resource)") else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.json
        // set additional headers if needed
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            
            DispatchQueue.main.async {
                if 200..<300 ~= statusCode && error == nil {
                    request.onSuccess(response: data).forEach(dispatch)
                } else {
                    request.onFailure(response: data).forEach(dispatch)
                }
            }
        }
        task.resume()
    }
}
