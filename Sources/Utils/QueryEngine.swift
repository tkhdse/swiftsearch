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


        
        let tokens = query.split(seperator: " ")
        if tokens.count > 1 {
            handlePhrase(tokens)
        }

        return await index.get(query)
    }

    public func insertDoc(document: sending Document) async -> Int {
        let ret = await self.index.insert(document: document)
        return ret
    }


    func handlePhrase(tokens: [String]) async -> [UUID:[Int]] {
        
        // prefix tree => 
        // root is tokens[0]

        "the cat jumps on the dog"

        // the -> [
        //          id1: [p1,p2,p3]
        //          id2: [p4,p5,p6]  
        //        ]

        // cat -> [
        //          id1: [p3+1]
        //          id2: [p4+1]
        //          id3: [p7]
        //        ]

        // jumps -> [
        //              id1: [p3+2]
        //              id2: [p4+2]
        //          ]

        // 


        class LinkedToken {
            var parent: LinkedToken

            public init(positions: [UUID:[Int]]) {
                self.parent = nil
                self.positions = positions
            }
        }

        var positions = await self.index.get(tokens[0])
        let root = LinkedToken()
        var cur = root
        var matches = []

        for i in 1...tokens.count-1 {
            let tkn = tokens[i]
            positions = await self.index.get(tkn)
            var node = LinkedToken(positions)

            
        }
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