
//  Double+Extension.swift


import UIKit

public extension Double {

    func string(maximumFractionDigits: Int = Int(2)) -> String {
        
        let s: String = "\(self)"
        let chunks = s.components(separatedBy: ".")
        if chunks.count == 2
        {
            if chunks[1] == "0"
            {
                return chunks[0]
            }
            
            var maximumFractionDigits = max(0, maximumFractionDigits - 1)
            maximumFractionDigits = min(maximumFractionDigits, chunks[1].count)
            let ending = chunks[1].substring(to: maximumFractionDigits)
            if ending == "0" || ending.isEmpty
            {
                return chunks[0]
            }
            return "\(chunks[0]).\(ending)"
        }
        else
        {
            return s
        }
        
//        let s:String = String(format: "%.\(maximumFractionDigits)f", self)
//        var offset:Int = -maximumFractionDigits - 1
//        for i in stride(from: 0, to: -maximumFractionDigits, by: -1) {
//            if s[s.index(s.endIndex, offsetBy: i - 1)] != "0" {
//                offset = i
//                break
//            }
//        }
//        return String(s[..<s.index(s.endIndex, offsetBy: offset)])
    }
    
    
    var formattedPrecisionsString: String
    {
        get
        {
            if self < 10000.0
            {
                return self.string(maximumFractionDigits: 1)
            }
    
            let thousands = self / 1000.0
            let millions = self / 1000000.0
            
            if (self < 1000000)
            {
                return "\(thousands.string(maximumFractionDigits: 1))K"
            }
            else
            {
                return "\(millions.string(maximumFractionDigits: 1))M"
            }
        }
    }
    
    
    func trunc(_ decimal:Int) -> Float {
        let temp = Float(self)
        let multiplier = powf(10,Float(decimal))
        let newNumber = temp*multiplier/multiplier
         
        return newNumber
    }
    
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.unitsStyle = style
        return formatter.string(from: self) ?? ""
      }
}
