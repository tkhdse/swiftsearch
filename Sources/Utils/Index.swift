import Foundation

public actor Index {
    // word -> ids -> position in doc(id)
    var data: [String: [UUID: Set<Int>]]
    var tokenizer: Tokenizer
    var docsList: [UUID:String]

    public init() {
        self.data = [:] // token -> [UUID -> [positions]]
        self.tokenizer = Tokenizer()
        self.docsList = [:]
    }

    public func insertDoc(document: sending Document) -> Int {
        let id = document.id
        let tokens = self.tokenizer.tokenize(input: document.content)

        for i in 0...tokens.count-1 {
            let token = tokens[i]

            var ids = self.data[token] ?? [:]
            var positions = ids[id] ?? []
            positions.insert(i)

            ids[id] = positions
            self.data[token] = ids
        }

        self.docsList[id] = document.content
        return 0
    }

    public func getDocs() -> [UUID:String] {
        return self.docsList
    }

    public func removeDoc(docId: UUID) -> Int {
        if self.docsList[docId] == nil {
            self.docsList.removeValue(forKey: docId)
        }

        // to do: update index structure

        return 0
    }

    func get(_ searchQuery: String) -> [UUID:Set<Int>] {
        if let val = self.data[searchQuery] {
            return val
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