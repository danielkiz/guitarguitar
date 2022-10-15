//
//  GuitarsViewController.swift
//  guitarguitar
//
//  Created by Danya on 10/15/22.
//

import UIKit

class GuitarsViewController: UIViewController {

    var guitars = [Guitar]()
    var forwarder: String?
    
    @IBOutlet weak var guitarsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
