import Foundation

public actor QueryEngine {
    var index: Index

    // support Boolean queries: AND, OR, NOT
    // phrase queries
    // prefix queries: "prefi*"
    // field queries: 

    public init(_ index: Index) {
        self.index = index
    }

    public func search(_ query: Sting) async -> [UUID:[Int]] {
        if query.isEmpty {
            return [:]
        }
        
        

        return await index.get(query)
    }

    public func insertDoc(document: sending Document) async -> Int {
        let ret = await self.index.insert(document: document)
        return ret
    }


    func parseCommand(_ cmd: String) {
        // support single-word queries first
        // cmd.split(seperator: " ")
        // use stack to support command chaining (??)
    }


    public func getIndex() -> Index {
        return self.index
    }
}