//
//  CharacterNavigationViewController.swift
//  DuckDuckGooseAPIApp
//
//  Created by MAC Consultant on 3/2/19.
//  Copyright © 2019 William Benfer. All rights reserved.
//

import UIKit

class CharacterNavigationViewController: UINavigationController {

    var character: Simpson?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if let dest = segue.destination as? CharacterDescriptionViewController {
            
            dest.character = character
        }
     
    }
 
    
}
