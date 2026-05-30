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
        print("tokens: \(tokens)")

        for i in 1...tokens.count-1 {
            let tkn = tokens[i]
            print("tkn: \(tkn)")

            if prev_token_data.isEmpty {
                break
            }

            // make sure this retrieves a copy, otherwise index itself will change
            let cur_token_data = await self.index.get(tkn) 
            print("current: \(cur_token_data)")

            // compare against curr token's UUID's & positions and narrow accordingly
            for uuid in prev_token_data.keys {
                if cur_token_data[uuid] == nil {
                    prev_token_data.removeValue(forKey: uuid)
                    continue
                }

                let positions = cur_token_data[uuid]!
                var prev_positions = prev_token_data[uuid]!

                for pos in prev_positions {
                    if !positions.contains(pos+i) {
                        prev_positions.remove(pos)
                    }
                }

                if prev_positions.isEmpty {
                    prev_token_data.removeValue(forKey: uuid)
                }
            }

            print("token_data: \(prev_token_data)")
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