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

    app.get("info") {req async throws -> [String] in 
        let index = await req.application.queryEngine.getIndex()
        let id_to_doc = await index.getDocs()

        var docs: [String] = []

        for (id, content) in id_to_doc {
            docs.append("\(id.uuidString): \(content)")
        }

        // let docs = uuidDocs.map{ id in id.uuidString }
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

        let index = await req.application.queryEngine.getIndex()
        await index.insertDoc(document: doc)
        return HTTPStatus.ok
    }


    app.delete("doc", ":docId") { req async throws in
        guard let docId = req.parameters.get("docId"), let id = UUID(docId) else {
            return HTTPStatus.badRequest
        }

        let index = await req.application.queryEngine.getIndex()
        await index.removeDoc(docId: id)
        return HTTPStatus.ok
    }

    // try app.register(collection: TodoController())
}
