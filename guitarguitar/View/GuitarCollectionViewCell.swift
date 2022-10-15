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
    
    func setCellWithValuesOf(_ guitar: Guitar) {
        updateUI(title: guitar.itemName, price: guitar.salesPrice, stock: guitar.qtyInStock, imageUrl: guitar.pictureMain)
    }
    
    private func updateUI(title: String?, price: Double?, stock: Int?, imageUrl: String?) {
        
        self.titleLabel.text = title!
        
        if stock! >= 1 {
            self.stockLabel.text = "In Stock"
        } else {
            self.stockLabel.text = "Out of Stock"
        }
        
        self.priceLabel.text = "£\(String(format: "%.2f", price!))"
        
        guard let guitarImageURL = URL(string: imageUrl!) else {
            self.imageView.image = UIImage(named: "guitarguitar2")
            return
        }
        
        // Before we download the image we clear out the old one
        self.imageView.image = nil
        getImageDataFrom(url: guitarImageURL)
        
    }
    
    // MARK: - Get image data
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                // Handle Empty Data
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
    
    // MARK: - Convert date format
    func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
    
}
