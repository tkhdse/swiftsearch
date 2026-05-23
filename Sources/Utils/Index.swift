import Foundation

public class Index {
    // word -> ids -> position in doc(id)
    var data: [String: [UUID: [Int]]]

    var tokenizer: Tokenizer

    public init() {
        self.data = [:]
        self.tokenizer = Tokenizer()
    }

    public func insert(document: Document) {
        let id = document.id
        var tokens = self.tokenizer.tokenize(input: document.content)

        for i in 0...tokens.count-1 {
            let token = tokens[i]

            var ids = self.data[token] ?? [:]
            var positions = ids[id] ?? []
            positions.append(i)

            ids[id] = positions
            self.data[token] = ids
        }
    }

    func remove(documentId: Int) {
        // implement later: given docId, scan through Index and remove instances of docId
        // if a key has no associated Ids, remove the key
    }

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