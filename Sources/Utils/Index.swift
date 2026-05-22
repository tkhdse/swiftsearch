import Foundation

public class Index {
    var data: [String: [UUID]]
    var tokenizer: Tokenizer

    public init() {
        self.data = [:]
        self.tokenizer = Tokenizer()
    }

    public func insert(document: Document) {
        let id = document.id
        var tokens = self.tokenizer.tokenize(input: document.content)

        for token in tokens {
            var ids = self.data[token] ?? []
            ids.append(id)
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
            print("\(key): \(value)")
        }
    }
}