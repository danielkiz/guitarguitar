//
//  ViewController.swift
//  guitarguitar
//
//  Created by Danya on 10/14/22.
//

import UIKit

class ViewController: UIViewController {

    var guitars = [Guitar]()
    
    let brandCollectionViewCell = BrandCollectionViewCell()
    var guitarViewModel = GuitarViewModel()
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    @IBOutlet weak var guitarsCollectionView: UICollectionView!
    @IBOutlet weak var seeAllButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGuitars()
        
        brandsCollectionView.dataSource = self
        brandsCollectionView.delegate = self
        brandCollectionViewCell.layer.cornerRadius = 15
        brandCollectionViewCell.layer.borderWidth = 5
        
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
            }
        } else if segue.identifier == "homeToSpecial" {
            if let destination = segue.destination as? GuitarsViewController {
                destination.guitars = guitars
                if let indexPath = brandsCollectionView?.indexPathsForSelectedItems?.first {
                    destination.identifier = brandCollectionViewCell.topBrands[indexPath.row]
                }
            }
        }
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dummyCell = UICollectionViewCell()
        if collectionView == self.brandsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brandCell", for: indexPath) as! BrandCollectionViewCell
            print(brandCollectionViewCell.topBrands[indexPath.row])
            cell.brandLabel.text = brandCollectionViewCell.topBrands[indexPath.row]
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
        if collectionView == self.brandsCollectionView {
            return brandCollectionViewCell.topBrands.count
        } else if collectionView == self.guitarsCollectionView {
            return 14
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.brandsCollectionView {
            print("clicked category")
            brandCollectionViewCell.backgroundColor = brandCollectionViewCell.hexStringToUIColor(hex: "#ec661a")
            brandCollectionViewCell.tintColor = UIColor.white
            performSegue(withIdentifier: "homeToSpecial", sender: self)
        } else if collectionView == self.guitarsCollectionView {
            print("clicked guitar")
            performSegue(withIdentifier: "homeToGuitar", sender: self)
        }
        
    }
    
}
