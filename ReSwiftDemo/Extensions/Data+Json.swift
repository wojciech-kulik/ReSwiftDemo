import Foundation

extension Data {
    func toObject<T:Codable>(_ type: T.Type) -> T? {
        return try? JSONDecoder().decode(type, from: self)
    }
}
