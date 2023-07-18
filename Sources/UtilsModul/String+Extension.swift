
//  String+Extension.swift

import UIKit

public extension String {
    
    
    var isValid: Bool
    {
        get
        {
            let str = self.trim()
            return str.length > 0
         }
    }
    
    var length: Int {
        return utf16.count
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start: String.Index = index(startIndex, offsetBy: bounds.lowerBound)
        let end: String.Index = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start: String.Index = index(startIndex, offsetBy: bounds.lowerBound)
        let end: String.Index = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    func trim() -> String
    {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func capitalizingFirstLetter(restLowerCased: Bool = true ) -> String {
        if self.isEmpty
        {
            return self
        }
        let rest = restLowerCased ? self.lowercased() : self
        return prefix(1).uppercased() + rest.dropFirst()
    }
    
    func lowercasingFirstLetter( ) -> String {
        if self.isEmpty
        {
            return self
        }
        return prefix(1).lowercased() + self.dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func fullRange() -> NSRange
    {
        return NSMakeRange(0, self.length)
    }
    
    
    func nsRange(of string: String) -> NSRange
    {
        return (self as NSString).range(of: string)
    }
    
    
    func getPath(forSize size: CGSize, scale: CGFloat = UIScreen.main.scale) -> String!
    {
        if self.hasSuffix("svg")
        {
            return self
        }

        
        var sizeString: String = ""
        if size.width != 0
        {
            sizeString = "width=\(Int(size.width * scale))"
        }
        else if size.height != 0
        {
            sizeString = "height=\(Int(size.height * scale))"
        }
        
        if self.contains("?")
        {
            return "\(self)&\(sizeString)"
        }
        else
        {
            return "\(self)?\(sizeString)"
        }
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func stringBefore(_ delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            return String(prefix(upTo: index))
        } else {
            return ""
        }
    }
    
    func stringAfter(_ delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            return String(suffix(from: index).dropFirst())
        } else {
            return ""
        }
    }
    func indexInt(of char: Character) -> Int? {
      return firstIndex(of: char)?.utf16Offset(in: self)
    }
    func hasHttpPrefix() -> Bool
    {
        return self.hasPrefix("http")
    }
    func slice(from: String, to: String) -> String?
    {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
