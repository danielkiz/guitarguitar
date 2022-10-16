//
//  ViewController.swift
//  guitarguitar
//
//  Created by Danya on 10/14/22.
//

import UIKit

class ViewController: UIViewController {

    var guitars = [Guitar]()
    
    let categoryCollectionViewCell = CategoryCollectionViewCell()
    var guitarViewModel = GuitarViewModel()
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var guitarsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGuitars()
        
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoryCollectionViewCell.layer.cornerRadius = 15
        categoryCollectionViewCell.layer.borderWidth = 5
        guitarsCollectionView.isUserInteractionEnabled = true
        
        posterView.layer.cornerRadius = 15
        posterView.layer.masksToBounds = true
    }
    
    func loadGuitars() {
        guitarViewModel.fetchGuitarsData { [weak self] in
            self!.guitarsCollectionView.dataSource = self
            self!.guitarsCollectionView.delegate = self
            self?.guitarsCollectionView.reloadData()
            self!.loadingView.isHidden = true
            self!.guitars = self!.guitarViewModel.guitars
        }
    }
    
    @IBAction func openWebsiteButton(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "https://www.guitarguitar.co.uk")! as URL)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToGuitar" {
            if let destination = segue.destination as? GuitarViewController {
                destination.guitars = guitars
                if let indexPath = guitarsCollectionView?.indexPathsForSelectedItems?.first {
                    destination.guitar = guitars[indexPath.row]
                }
                //destination.guitars = guitars
            }
        /*} else if segue.identifier == "homeToCategory" {
            if let destination = segue.destination as? GuitarsViewController {
                destination.guitars = guitars
                if let indexPath = guitarsCollectionView?.indexPathsForSelectedItems?.first {
                    destination.forwarder = categoryCollectionViewCell.basicCategories[indexPath.row]
                }
            }
        }*/
        }
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dummyCell = UICollectionViewCell()
        if collectionView == self.categoriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            print(categoryCollectionViewCell.basicCategories[indexPath.row])
            cell.categoryLabel.text = categoryCollectionViewCell.basicCategories[indexPath.row]
            return cell
        } else if collectionView == self.guitarsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guitarCell", for: indexPath) as! GuitarCollectionViewCell
            let guitar = guitarViewModel.cellForAt(indexPath: indexPath)
            cell.setCellWithValuesOf(guitar)
            return cell
        }
        return dummyCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.categoriesCollectionView {
            return categoryCollectionViewCell.basicCategories.count
        } else if collectionView == self.guitarsCollectionView {
            return 14
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.categoriesCollectionView {
            print("clicked category")
            categoryCollectionViewCell.backgroundColor = categoryCollectionViewCell.hexStringToUIColor(hex: "#ec661a")
            categoryCollectionViewCell.tintColor = UIColor.white
            performSegue(withIdentifier: "homeToCategory", sender: self)
        } else if collectionView == self.guitarsCollectionView {
            print("clicked guitar")
            performSegue(withIdentifier: "homeToGuitar", sender: self)
        }
    }
    
}
