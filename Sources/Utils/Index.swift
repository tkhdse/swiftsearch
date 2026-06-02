import Foundation

public actor Index {
    // word -> ids -> position in doc(id)
    var data: [String: [UUID: Set<Int>]]
    var tokenizer: Tokenizer
    var docsList: [UUID:Document]

    public init() {
        self.data = [:] // token -> [UUID -> [positions]]
        self.tokenizer = Tokenizer()
        self.docsList = [:]
    }

    public func insertDoc(document: sending Document) -> Int {
        let id = document.id
        let tokens = self.tokenizer.tokenize(input: document.body)

        for i in 0...tokens.count-1 {
            let token = tokens[i]

            var ids = self.data[token] ?? [:]
            var positions = ids[id] ?? []
            positions.insert(i)

            ids[id] = positions
            self.data[token] = ids
        }

        self.docsList[id] = document
        return 0
    }

    public func getDocs() async -> [UUID:Document] {
        return self.docsList
    }

    public func removeDoc(docId: UUID) -> Bool {
        guard self.docsList[docId] != nil else {
            return false
        }
        
        self.docsList.removeValue(forKey: docId)
        // to do: update index structure
        return true
    }

    func get(_ searchQuery: String) -> [UUID:Set<Int>] {
        if var token_data = self.data[searchQuery] {
            
            // lazy deletion: check for deleted document keys
            for (id,_) in token_data {
                if self.docsList[id] == nil {
                    token_data.removeValue(forKey: id)
                }
            }
            return token_data
        }
        return [:]
    }


    // public func search(_ query: String) {
    //     let words = query.components(separateBy: " ")

    // }

    public func peek() {
        print("Printing index ...")
        for (key,value) in self.data {
            print("\(key): {")
            for (id, positions) in value {
                print("\t\(id): \(positions)")
            }
            print("}")
        }
    }
}