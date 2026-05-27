// import Fluent
import Vapor
import Utils



func routes(_ app: Application) throws {
    app.get { req async -> String in
        // try await req.view.render("index", ["title": "Hello Vapor!"])
        "OK"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.get("query", ":query") { req async -> [String:[Int]] in
        let query = req.parameters.get("query")!
        let results = await req.application.queryEngine.query(query)
        let ret = Dictionary(uniqueKeysWithValues: 
            results.map { (id, pos) in (id.uuidString, pos) }
        )
        return ret
    }

    // try app.register(collection: TodoController())
}
