//
//  Character.swift
//  DuckDuckGooseAPIApp
//
//  Created by MAC Consultant on 3/1/19.
//  Copyright © 2019 William Benfer. All rights reserved.
//

import UIKit

/*
    JSON FORMAT
 ------------------
 
 JSON{}
    RelateTopics[]
        0{}
            Icon{}
                URL: String
            Text: String
            Result: String
 
 */

// new top-level to contain Simpsons
struct Simpsons: Decodable {
    var simpsons: [Simpson]
    enum CodingKeys: String, CodingKey {
        case simpsons = "RelatedTopics"
    }
}

// new internal-level to contain decoded objects &
// immediate population of required fields at init
class Simpson: Decodable {
    var name: String
    var description: String
    var imageURL: String
    var image: Data?
    
    private let text: String
    private let result: String
    private let icon: Icon
    
    struct Icon : Decodable{
        var URL: String
    }
    
    enum CodingKeys: String, CodingKey {
        case text = "Text"
        case result = "Result"
        case icon = "Icon"
    }
    
    required init(from decoder: Decoder) throws {
        // default init portion Decodable provides
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: CodingKeys.text)
        result = try container.decode(String.self, forKey: CodingKeys.result)
        icon = try container.decode(Icon.self, forKey: CodingKeys.icon)
        
        // additional custom population
        let separator = " - "
        let textComponents = text.components(separatedBy: separator)
        name = textComponents[0]
        description = textComponents[1]
        imageURL = icon.URL
    }
}

// MARK: - Old Decodable & Object

// Object to represent structure of the JSON
struct TopLevel: Decodable{
    var RelatedTopics : [RelatedTopicsS]
    
    struct RelatedTopicsS: Decodable {
        var Icon : IconS
        var Text : String, Result: String
        struct IconS : Decodable{
            var URL: String
        }
    }
}

// internal object for character representation
class Char{
    var name: String, description: String, imageURL: String
    var image: Data?
    init(_ result: String, _ imageURL: String){
        var next = result.startIndex
        while result[next] != "-"{
            next = result.index(after: next)
        
            if(next == result.endIndex){
                self.name = result
                self.description = ""
                self.imageURL = imageURL
                return
            }
        }
        self.name = String(result[result.startIndex..<next])
        next = result.index(after: next)
        self.description = String(result[next..<result.endIndex])
        self.imageURL = imageURL
    }
}

