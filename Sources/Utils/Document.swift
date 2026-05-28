import Foundation

public struct Document {
    public var id: UUID
    public var content: String

    public init(body: String) {
        self.id = UUID()
        self.content = body
    }

    public func display() {
        print("\(self.id)\n\(self.content)")
    }
}