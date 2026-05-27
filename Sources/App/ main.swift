import Utils

let doc1 = Document(body: "the fox jumps over the dog and eats the squirrel")
let doc2 = Document(body: "kitty kat")
let doc3 = Document(body: "i like the fox kat and dog")

print("doc1: \(doc1.id)")
print("doc2: \(doc2.id)")
print("doc3: \(doc3.id)")

var index = Index()

index.insert(document: doc1)
index.insert(document: doc2)
index.insert(document: doc3)

// index.peek()

var qe = QueryEngine(index)
print(qe.query("the"))