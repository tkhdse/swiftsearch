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

    public func search(_ query: String) async -> [UUID:Set<Int>] {
        if query.isEmpty {
            return [:]
        }


        
        let tokens = query.components(separatedBy: " ")
        if tokens.count > 1 {
            return await handlePhrase(tokens: tokens)
        }

        return await index.get(query)
    }

    public func insertDoc(document: sending Document) async -> Int {
        let ret = await self.index.insert(document: document)
        return ret
    }


    func handlePhrase(tokens: [String]) async -> [UUID:Set<Int>] {
        
        var prev_token_data = await self.index.get(tokens[0])

        for i in 1...tokens.count-1 {
            let tkn = tokens[i]

            // make sure this retrieves a copy, otherwise index itself will change
            var cur_token_data = await self.index.get(tkn) 

            // compare against previous token's UUID's & positions
            for uuid in cur_token_data.keys {
                if prev_token_data[uuid] == nil {
                    cur_token_data.removeValue(forKey: uuid)
                    continue
                }

                var positions = cur_token_data[uuid]!
                let prev_positions = prev_token_data[uuid]!

                for pos in positions {
                    if !prev_positions.contains(pos) {
                        positions.remove(pos)
                    }
                }
            }

            prev_token_data = cur_token_data
        }

        return prev_token_data
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