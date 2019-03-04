//
//  ViewController.swift
//  DuckDuckGooseAPIApp
//
//  Created by MAC Consultant on 3/1/19.
//  Copyright © 2019 William Benfer. All rights reserved.
//

import UIKit

class CharacterTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var characters: [Simpson] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
        CharacterService.downloadJSON(){ characters in
            
            self.characters = characters
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Prepare for seque")
        
        //TODO: Prevent crashes
        let dest = segue.destination as! CharacterCollectionViewController
        dest.characters = self.characters
        dest.loadImages()
    }
    
}


extension CharacterTableViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return characters.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = characters[indexPath.row].name
        return cell
    }
    
}

extension CharacterTableViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nav = (self.tabBarController?.navigationController as! CharacterNavigationViewController)
        
        nav.character = characters[indexPath.row]
        
        self.tabBarController?.navigationController?.performSegue(withIdentifier: "one", sender: nil)
        
        
        
        
        
    }
}

