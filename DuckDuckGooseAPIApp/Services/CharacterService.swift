//
//  PokemonService.swift
//  DuckDuckGooseAPIApp
//
//  Created by MAC Consultant on 3/1/19.
//  Copyright © 2019 William Benfer. All rights reserved.
//

import Foundation


class CharacterService{
    
    static let urlBeg = "https://api.duckduckgo.com/?q="
    static let urlEnd = "+characters&format=json"
    
    
    
    
    static var urlString = urlBeg + "simpsons" + urlEnd
    
    static func setFranchise(_ u : String){
        
        var s = ""
        
        var b = false
        for c in u{
            if c != " "{
                b = false
                s += String(c)
            }else{
                if(!b){
                    s += "+"
                    b = true
                }
            }
        }
        
        
        urlString = urlBeg + s + urlEnd
    }
    
    static func downloadPicture(for character: Character,
                         completion: @escaping (Character)->()) {
     
        
        
        guard let url = URL(string: character.imageURL) else {
            return
        }
 
        URLSession.shared.dataTask(with: url) { (data, _, _) in
        
            character.image = data
            completion(character)
        
        }.resume()
        
        
    }
    
    
    
    
    static func downloadJSON(completion: @escaping ([Character])->() ){
        
        
        guard let url = URL(string: CharacterService.urlString) else {
            print("Invalid url")
            return
        }
        
        var request = URLRequest(url: url,
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        
       
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let dat = data {
                
                let decoder = JSONDecoder()
                do {
                    
                    let t = try decoder.decode(TopLevel.self, from: dat)
                    
                    var characters = [Character]()
                    for r in t.RelatedTopics{
                        
                        characters.append(Character(r.Text, r.Icon.URL))
                    }
                    
                    completion(characters)
                    
                }
                catch {
                    
                    print(error)
                }
            }
        }.resume()
    }
    
}
