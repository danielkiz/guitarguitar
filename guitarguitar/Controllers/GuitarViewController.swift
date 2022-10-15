//
//  GuitarViewController.swift
//  guitarguitar
//
//  Created by Danya on 10/15/22.
//

import UIKit

class GuitarViewController: UIViewController {

    var guitar: Guitar?
    var guitars = [Guitar]()
    
    @IBOutlet weak var startingView: UIView!
    @IBOutlet weak var startingImageView: UIImageView!
    @IBOutlet weak var startingTitleLabel: UILabel!
    @IBOutlet weak var startingPrice: UILabel!
    
    @IBOutlet weak var specsView: UIView!
    @IBOutlet weak var specsTitleLabel: UILabel!
    @IBOutlet weak var specsDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(guitar)
    }
    
    @IBAction func specAction(_ sender: Any) {
        specsView.isHidden = false
    }
    
    @IBAction func closeAction(_ sender: Any) {
        specsView.isHidden = true
    }
    
}
