// import Fluent
import Vapor
import Utils


func routes(_ app: Application) throws {
    app.get { req async -> String in
        // try await req.view.render("index", ["title": "Hello Vapor!"])
        "OK"
    }

    // app.get("hello") { req async -> String in
    //     "Hello, world!"
    // }

    app.get("info") {req -> [String] in 
        let index = req.application.queryEngine.getIndex()
        let uuidDocs = index.getDocs()
        let docs = uuidDocs.map{ id in id.uuidString }
        return docs
    }

    app.get("query", ":query") { req async -> [String:[Int]] in
        let query = req.parameters.get("query")!
        let results = await req.application.queryEngine.query(query)
        let ret = Dictionary(uniqueKeysWithValues: 
            results.map { (id, pos) in (id.uuidString, pos) }
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
