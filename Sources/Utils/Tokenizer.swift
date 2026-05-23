import Foundation

public class Tokenizer {
    public func tokenize(input: String) -> [String] {
        let ret = input.components(separatedBy: " ")
        return ret
    }
}