class Tokenizer {
    func tokenize(input: String) -> [String] {
        let tmp = "hello world"
        let ret = [tmp]
        return ret
    }
}

var input = "tokenize this"
var tokenizer = Tokenizer()
let out = tokenizer.tokenize(input: input)
print(out)