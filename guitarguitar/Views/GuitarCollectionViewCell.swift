//
//  GuitarCollectionViewCell.swift
//  guitarguitar
//
//  Created by Danya on 10/15/22.
//

import UIKit

class GuitarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var addFavouriteButton: UIButton!
    
    func setCellWithValuesOf(_ guitar: Guitar) {
        updateUI(title: guitar.itemName, price: guitar.salesPrice, stock: guitar.qtyInStock, imageUrl: guitar.pictureMain, brandName: guitar.brandName)
    }
    
    func updateUI(title: String?, price: Double?, stock: Int?, imageUrl: String?, brandName: String?) {
        
        self.titleLabel.text = title!
        
        if stock! >= 1 {
            self.stockLabel.text = "In Stock"
        } else {
            self.stockLabel.text = "Out of Stock"
        }
        
        self.brandLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        self.brandLabel.text = brandName?.uppercased()
        
        self.priceLabel.text = "£\(String(format: "%.2f", price!))"
        
        guard let guitarImageURL = URL(string: imageUrl!) else {
            self.imageView.image = UIImage(named: "guitarguitar2")
            return
        }
        
        self.imageView.image = nil
        getImageDataFrom(url: guitarImageURL)
        
    }
    
    func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Empty Data")
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.imageView.image = image
                }
            }
        }.resume()
    }
    
    @IBAction func addFavouriteAction(_ sender: Any) {
        
    }
    
}
