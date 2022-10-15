//
//  ViewController.swift
//  guitarguitar
//
//  Created by Danya on 10/14/22.
//

import UIKit

class ViewController: UIViewController {

    let categoryCollectionViewCell = CategoryCollectionViewCell()
    private var guitarViewModel = GuitarViewModel()
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var guitarsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGuitars()
        
        posterView.layer.cornerRadius = 15
        posterView.layer.masksToBounds = true
        
        categoryCollectionViewCell.layer.cornerRadius = 15
        categoryCollectionViewCell.layer.masksToBounds = true
        categoryCollectionViewCell.layer.borderColor = UIColor.black.cgColor
        categoryCollectionViewCell.layer.borderWidth = 1
    }
    
    private func loadGuitars() {
        guitarViewModel.fetchGuitarsData { [weak self] in
            self?.guitarsCollectionView.dataSource = self
            self?.guitarsCollectionView.reloadData()
            self!.loadingView.isHidden = true
        }
    }
    
    @IBAction func openWebsiteButton(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "https://www.guitarguitar.co.uk")! as URL)
    }

}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "guitarCell", for: indexPath) as! GuitarCollectionViewCell
        let guitar = guitarViewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(guitar)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guitarViewModel.numberOfItemsInSectionHome()
    }
}
