//
//  BrandCollectionViewCell.swift
//  guitarguitar
//
//  Created by Danya on 10/14/22.
//

import UIKit

class BrandCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var brandLabel: UILabel!
    
    let topBrands = ["Yamaha", "Martin", "Alvarez", "Gretsch", "Sigma", "Epiphone"]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.backgroundColor = hexStringToUIColor(hex: "#eaeded").cgColor
        layer.masksToBounds = true
        layer.cornerRadius = 15
    }
    
    func hexStringToUIColor(hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }}
