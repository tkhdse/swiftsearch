import Foundation

public struct Document : Sendable {
    public var id: UUID
    public var title: String
    public var body: String

    public init(title: String, body: String) {
        self.id = UUID()
        self.title = title
        self.body = body
    }

    public func display() {
        print("\(self.id)\n\(self.title)\n\(self.body)")
    }
}