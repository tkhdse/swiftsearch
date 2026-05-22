import Foundation

public class Document {
    public var id: UUID
    public var content: String

    public init(body: String) {
        self.id = UUID()
        self.content = body
    }
}