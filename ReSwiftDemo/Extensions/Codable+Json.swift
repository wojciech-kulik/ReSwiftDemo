import Foundation

extension Encodable {
    func toJson() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
