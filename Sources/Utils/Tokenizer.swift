import Foundation

public class Tokenizer {
    public func tokenize(input: String) -> [String] {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        let ret = trimmed.components(separatedBy: " ")
        return ret
    }
}