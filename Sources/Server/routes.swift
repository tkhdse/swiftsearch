// import Fluent
import Vapor
import Utils

struct Query: Content {
    var q: String?
}

struct DocumentUpload: Content {
    var title: String?
    var body: String?
}

func routes(_ app: Application) throws {
    app.get { req async -> String in
        // try await req.view.render("index", ["title": "Hello Vapor!"])
        "OK"
    }

    app.get("info") {req async throws -> [[String:[String:String]]] in 
        let index = await req.application.queryEngine.getIndex()
        let id_to_doc = await index.getDocs()

        var docs: [[String:[String:String]]] = []

        for (id, document) in id_to_doc {
            let currDoc = [document.id.uuidString : [document.title : document.body]]
            docs.append(currDoc)
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
        // guard let body = req.body.string else { throw Abort(.badRequest) }
        let payload = try req.content.decode(DocumentUpload.self)//  else { throw Abort(.badRequest) }

        guard let title = payload.title, let body = payload.body else {
            throw Abort(.badRequest, reason: "Invalid document format received")
        }

        let doc = Document(title: title, body: body)

        let index = await req.application.queryEngine.getIndex()
        await index.insertDoc(document: doc)
        return HTTPStatus.ok
    }


    app.delete("doc", ":docId") { req async throws in
        guard let docId = req.parameters.get("docId"), let id = UUID(docId) else {
            // return HTTPStatus.badRequest
            throw Abort(.badRequest, reason: "Invalid document ID format")
        }

        let index = await req.application.queryEngine.getIndex()
        let success = await index.removeDoc(docId: id)

        guard success else {
            throw Abort(.notFound, reason: "Suppled docId \(id) not found")
        }

        return HTTPStatus.ok
    }

    // try app.register(collection: TodoController())
}
