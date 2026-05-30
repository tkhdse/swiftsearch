// import Fluent
import Vapor
import Utils

struct Query: Content {
    var q: String?
}

func routes(_ app: Application) throws {
    app.get { req async -> String in
        // try await req.view.render("index", ["title": "Hello Vapor!"])
        "OK"
    }

    // app.get("hello") { req async -> String in
    //     "Hello, world!"
    // }

    app.get("info") {req throws -> [String] in 
        let index = req.application.queryEngine.getIndex()
        let uuidDocs = index.getDocs()
        let docs = uuidDocs.map{ id in id.uuidString }
        return docs
    }

    app.get("search") { req async throws -> [String:[Int]] in
        let queryParams = try req.query.decode(Query.self) //req.parameters.get("query")!
        guard let query = queryParams.q else {
            return [:]
        }

        let results = await req.application.queryEngine.search(query)
        let ret = Dictionary(uniqueKeysWithValues: 
            results.map { (id, pos) in (id.uuidString, Array(pos)) }
        )
        return ret
    }

    app.post("insert") { req async throws in 
        guard let body = req.body.string else { throw Abort(.badRequest)}
        let doc = Document(body: body)
        await req.application.queryEngine.insertDoc(document: doc)
        return HTTPStatus.ok
    }

    // try app.register(collection: TodoController())
}
