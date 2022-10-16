//
//  GuitarsViewController.swift
//  guitarguitar
//
//  Created by Danya on 10/15/22.
//

import UIKit

class GuitarsViewController: UIViewController {
    
    @IBOutlet weak var guitarsCollectionView: UICollectionView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    var guitarViewModel = GuitarViewModel()
    var guitars = [Guitar]()
    var identifier: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if identifier == nil {
            loadGuitars()
        } else {
            loadSearchGuitars(identifier: identifier!)
            categoryLabel.text = identifier!
        }
    }
    
    func loadGuitars() {
        guitarViewModel.fetchGuitarsData { [weak self] in
            self!.guitarsCollectionView.dataSource = self
            self!.guitarsCollectionView.delegate = self
            self!.guitarsCollectionView.reloadData()
            self!.loadingView.isHidden = true
            self!.guitars = self!.guitarViewModel.guitars
        }
    }
    
    func loadSearchGuitars(identifier: String) {
        guitarViewModel.searchGuitarsData(identifier: identifier) {
            self.guitarsCollectionView.dataSource = self
            self.guitarsCollectionView.delegate = self
            self.guitarsCollectionView.reloadData()
            self.loadingView.isHidden = true
            self.guitars = self.guitarViewModel.guitars
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "specialToGuitar" {
            if let destination = segue.destination as? GuitarViewController {
                destination.guitars = guitars
                if let indexPath = guitarsCollectionView?.indexPathsForSelectedItems?.first {
                    destination.guitar = guitars[indexPath.row]
                }
            }
        }
    }

}

extension GuitarsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guitarCell", for: indexPath) as! GuitarCollectionViewCell
        let guitar = guitarViewModel.cellForAt(indexPath: indexPath)
        cell.setCellWithValuesOf(guitar)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guitarViewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "specialToGuitar", sender: self)
    }
    
}
