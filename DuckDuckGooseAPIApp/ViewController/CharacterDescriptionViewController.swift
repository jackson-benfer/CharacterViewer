//
//  CharacterDescriptionViewController.swift
//  DuckDuckGooseAPIApp
//
//  Created by MAC Consultant on 3/2/19.
//  Copyright © 2019 William Benfer. All rights reserved.
//

import UIKit

class CharacterDescriptionViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var character: Simpson!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = character.name
        descLabel.text = character.description
        
        if let image = character.image{
            self.imageView.image = UIImage(data: image)
        }else{
            imageView.image = UIImage(named: "donut.jpg")
            
            CharacterService.downloadPicture(for: character){ c in
                DispatchQueue.main.async {
                    guard let i = c.image else{return}
                    self.imageView.image = UIImage(data: i)
                }
            }
        }
    }
    
}
