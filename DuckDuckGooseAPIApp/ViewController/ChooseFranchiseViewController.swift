//
//  ChooseFranchiseViewController.swift
//  DuckDuckGooseAPIApp
//
//  Created by MAC Consultant on 3/2/19.
//  Copyright © 2019 William Benfer. All rights reserved.
//

import UIKit

class ChooseFranchiseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    let suggestions = ["Simpsons", "Star Wars", "A Song of Ice and Fire", "Spongebob", "Batman", "Spiderman", "Marvel Comics", "South Park", "Family Guy", "Avatar", "Mario", "Harry Potter", "Shrek"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let t = textField.text ?? "simpsons"
        CharacterService.setFranchise(t)
        
        if let dest = segue.destination as? UITabBarController {
            
            if let vcS = dest.viewControllers{
                
                for vc in vcS{
                    if let table = vc as? CharacterTableViewController{
                        table.characters = [Simpson]()
                    }
                    
                    if let collection = vc as? CharacterCollectionViewController{
                        collection.characters = [Simpson]()
                    }
                    
                    
                    
                }
                
            }
            
        }
      
        
    }
 

}



extension ChooseFranchiseViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        textField.text = suggestions[indexPath.row]
        self.performSegue(withIdentifier: "two", sender: nil)
    }
}


extension ChooseFranchiseViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0{
            return suggestions.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = suggestions[indexPath.row]
        return cell
    }
    
    
}
