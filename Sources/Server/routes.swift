// import Fluent
import Vapor
import Utils

// extension Document: Content {}
public struct File : Content {
    var name: String
    var path: String
    var data: Data
}


// ideally move to Parser.swift (later)
public class Parser {
    public func parse(file: File) -> Document {
        return Document(body: String(data: file.data, encoding: .utf8)!)
    }
}


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

    app.post("insert") { req async throws in 
        // let recv_file = try req.content.decode(File.self)
        guard let body = req.body.string else { throw Abort(.badRequest)}
        let doc = Document(body: body)
        // let parser = Parser()
        // let doc = parser.parse(file: recv_file)

        print(doc.display())
        await req.application.queryEngine.insertDoc(document: doc)
        return HTTPStatus.ok
    }

    // try app.register(collection: TodoController())
}
