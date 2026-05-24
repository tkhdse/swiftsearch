import Foundation

public class QueryEngine {
    var index: Index

    // support Boolean queries: AND, OR, NOT
    // phrase queries
    // prefix queries: "prefi*"
    // field queries: 

    public init(_ index: Index) {
        self.index = index
    }

    public func query(_ token: String) -> [UUID:[Int]] {
        if !token.isEmpty {
            return index.retrieveDocs(token)
        }
        return [:]
    }


    func parseCommand(_ cmd: String) {
        // support single-word queries first

        // cmd.split(seperator: " ")

        // use stack to support command chaining (??)
    }

}