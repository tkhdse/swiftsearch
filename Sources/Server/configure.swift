import NIOSSL
import Vapor
import Utils


extension Application {
    private struct QueryEngineKey: StorageKey {
        typealias Value = QueryEngine
    }

    var queryEngine: QueryEngine {
        get { storage[QueryEngineKey.self]! }
        set { storage[QueryEngineKey.self] = newValue }
    }

}

public func configure(_ app: Application) async throws {

    let index = Index()
    app.queryEngine = QueryEngine(index)

    // register routes
    try routes(app)
}
