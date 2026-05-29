import Foundation

public actor Index {
    // word -> ids -> position in doc(id)
    var data: [String: [UUID: [Int]]]
    var tokenizer: Tokenizer
    var docsList: [UUID]

    public init() {
        self.data = [:] // token -> [UUID -> [positions]]
        self.tokenizer = Tokenizer()
        self.docsList = []
    }

    public func insert(document: sending Document) -> Int {
        let id = document.id
        let tokens = self.tokenizer.tokenize(input: document.content)

        for i in 0...tokens.count-1 {
            let token = tokens[i]

            var ids = self.data[token] ?? [:]
            var positions = ids[id] ?? []
            positions.append(i)

            ids[id] = positions
            self.data[token] = ids
        }

        self.docsList.append(id)
        return 0
    }

    public func getDocs() -> [UUID] {
        return self.docsList
    }

    func remove(documentId: Int) {
        // implement later: given docId, scan through Index and remove instances of docId
        // if a key has no associated Ids, remove the key
    }

    func get(_ searchQuery: String) -> [UUID:[Int]] {
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