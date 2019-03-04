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


struct TopLevel: Decodable{

    var RelatedTopics : [RelatedTopicsS]
    
    struct RelatedTopicsS: Decodable {
        var Icon : IconS
        var Text : String
        var Result: String
    
        struct IconS : Decodable{
            var URL: String
        }
    }

}



class Character{
    
    var name: String
    var description: String
    var imageURL: String
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

