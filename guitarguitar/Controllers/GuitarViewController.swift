//
//  GuitarViewController.swift
//  guitarguitar
//
//  Created by Danya on 10/15/22.
//

import UIKit

class GuitarViewController: UIViewController {

    var guitar: Guitar?
    let guitarModel = GuitarModel()
    var guitars = [Guitar]()
    
    @IBOutlet weak var startingView: UIView!
    @IBOutlet weak var startingImageView: UIImageView!
    @IBOutlet weak var startingTitleLabel: UILabel!
    @IBOutlet weak var startingPrice: UILabel!
    
    @IBOutlet weak var specsView: UIView!
    @IBOutlet weak var specsTitleLabel: UILabel!
    @IBOutlet weak var specsDescription: UITextView!
    @IBOutlet weak var brandPickupLabel: UILabel!
    @IBOutlet weak var colourBodyshapeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startingTitleLabel.text = guitar?.itemName!
        specsTitleLabel.text = guitar?.itemName!
        
        let price = guitar?.salesPrice
        startingPrice.text = "£\(String(format: "%.2f", price!))"
        
        let imageUrl = guitar?.pictureMain
        getImageDataFrom(url: URL(string: (imageUrl!))!)
        
        let brand = guitar?.brandName!
        let pickup = guitarModel.pickups["\(Int((guitar?.pickup!)!))"]
        brandPickupLabel.text = "\(brand!) | \(pickup!)"
        
        let colour = guitarModel.colours["\(Int((guitar?.colour!)!))"]
        let bodyShape = guitarModel.bodyShapes["\(Int((guitar?.bodyShape!)!))"]
        colourBodyshapeLabel.text = "\(colour!) | \(bodyShape!)"
        
        let regex = try! NSRegularExpression(pattern: "<.*?>", options: [.caseInsensitive])
        let range = NSMakeRange(0, (guitar?.productDetail?.count)!)
        let htmlLessString: String = regex.stringByReplacingMatches(in: (guitar?.productDetail)!, options: [],
            range: range, withTemplate: "")
        
        specsDescription.text = htmlLessString
    }
    
    func getImageDataFrom(url: URL) {
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
                    self.startingImageView.image = image
                }
            }
        }.resume()
    }
    
    @IBAction func specAction(_ sender: Any) {
        specsView.isHidden = false
    }
    
    @IBAction func closeAction(_ sender: Any) {
        specsView.isHidden = true
    }
    
}
