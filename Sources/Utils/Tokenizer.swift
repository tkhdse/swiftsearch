import Foundation

public class Tokenizer {
    public func tokenize(input: String) -> [String] {
        // let tmp = "hello world"
        // let ret = [tmp]
        let ret = input.split(separator: " ").map(String.init)
        return ret
    }
}