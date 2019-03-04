//
//  CharacterCollectionViewController.swift
//  DuckDuckGooseAPIApp
//
//  Created by MAC Consultant on 3/1/19.
//  Copyright © 2019 William Benfer. All rights reserved.
//

import UIKit

class CharacterCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var characters : [Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        CharacterService.downloadJSON(){ characters in
            
            //print("JSON Loaded")
            self.characters = characters
            DispatchQueue.main.async {
                
            
            self.collectionView.reloadData()
        
            }
        }
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func loadImages(){
        for c in characters{
            
            CharacterService.downloadPicture(for: c){ character in
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
}

extension CharacterCollectionViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            //return
            return characters.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterCollectionViewCell
        
        if let image = characters[indexPath.row].image{
            cell.imageView.image = UIImage(data: image)
        }else{
            cell.imageView.image = UIImage(named: "donut.jpg")
            
            CharacterService.downloadPicture(for: characters[indexPath.row]){ character in
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
        
        return cell
    }
    
    
}


extension CharacterCollectionViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let nav = (self.tabBarController?.navigationController as! CharacterNavigationViewController)
        
        nav.character = characters[indexPath.row]
        
        self.tabBarController?.navigationController?.performSegue(withIdentifier: "one", sender: nil)
        
        
    }

}



extension CharacterCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width / 3
        let height = width
        let size = CGSize(width: width, height: height)
        return size
    }
}

