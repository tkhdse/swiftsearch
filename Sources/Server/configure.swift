import NIOSSL
// import Fluent
// import FluentPostgresDriver
// import Leaf
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

// configures your application
public func configure(_ app: Application) async throws {

    // app.views.use(.leaf)
    // let doc1 = Document(body: "the fox jumps over the dog and eats the squirrel")
    // let doc2 = Document(body: "kitty kat")
    // let doc3 = Document(body: "i like the fox kat and dog")

    let index = Index()

    // await index.insert(document: doc1)
    // await index.insert(document: doc2)
    // await index.insert(document: doc3)

    app.queryEngine = QueryEngine(index)

    // register routes
    try routes(app)
}
