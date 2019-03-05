import Foundation
import ReSwift

enum Middlewares {
    static let all: [Middleware<AppState>] = [getLoggerMiddleware(), getAuthMiddleware(), getApiMiddleware()]
    static let restClient = AppDelegate.container.resolve(NetworkClient.self)!
}
