//
//  JSON.swift
//  RxPokedex
//
//  Created by Yoav Dror on 15/07/2020.
//  Copyright © 2020 Yoav Dror. All rights reserved.
//

import Foundation




public extension Dictionary {
    
    var toJson: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
     func printJson() {
        print(toJson)
    }
    
}

public struct JSON {
    private init(){}
    
    public static func dataToString(data: Data?) -> String {
        guard let dataToPrint = data else {
            
            return ""
        }
        do {
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: dataToPrint, options: []) as? [String: Any] {
                // try to read out a string array
                return json.toJson
            }
        } catch let error as NSError {
            return error.localizedDescription
        }
        return ""
    }
}


