// import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async -> String in
        // try await req.view.render("index", ["title": "Hello Vapor!"])
        "OK"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    // try app.register(collection: TodoController())
}
