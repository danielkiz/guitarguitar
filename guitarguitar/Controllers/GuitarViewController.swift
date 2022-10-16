//
//  GuitarViewController.swift
//  guitarguitar
//
//  Created by Danya on 10/15/22.
//

import UIKit

class GuitarViewController: UIViewController {

    var guitar: Guitar?
    var guitarModel = GuitarModel()
    var guitarSongViewModel = GuitarSongViewModel()
    var guitarSongs = [GuitarSong]()
    var guitars = [Guitar]()
    
    var spotifyLink: String?
    var youtubeLink: String?
    
    @IBOutlet weak var startingView: UIView!
    @IBOutlet weak var startingImageView: UIImageView!
    @IBOutlet weak var startingTitleLabel: UILabel!
    @IBOutlet weak var startingPrice: UILabel!
    @IBOutlet weak var startingFavouritesButton: UIButton!
    
    @IBOutlet weak var specsView: UIView!
    @IBOutlet weak var specsTitleLabel: UILabel!
    @IBOutlet weak var specsDescription: UITextView!
    @IBOutlet weak var brandPickupLabel: UILabel!
    @IBOutlet weak var colourBodyshapeLabel: UILabel!
    @IBOutlet weak var listenSpotifyButton: UIButton!
    @IBOutlet weak var listenYoutubeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listenSpotifyButton.titleLabel?.textAlignment = .center
        listenYoutubeButton.titleLabel?.textAlignment = .center
        
        startingFavouritesButton.layer.cornerRadius = 12
        startingFavouritesButton.layer.masksToBounds = true
        
        loadGuitarSongs(id: (guitar?.skU_ID!)!)
        
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
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
            
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        specsView.layer.shadowColor = UIColor.lightGray.cgColor
        specsView.layer.cornerRadius = 18
        specsView.layer.shadowOpacity = 1
        specsView.layer.shadowOffset = .zero
        specsView.layer.shadowRadius = 3
    }
    
    func loadGuitarSongs(id: String) {
        guitarSongViewModel.fetchGuitarSongsData { [weak self] in
            let guitarSong = GuitarSongData().songData.filter({ $0.skU_ID == id}).first
            if guitarSong != nil {
                self!.spotifyLink = "https://open.spotify.com/track/\(guitarSong?.spotifyId!)"
                self!.youtubeLink = guitarSong?.youtubeUrl!
            } else {
                self!.listenSpotifyButton.titleLabel!.text = "Not Available"
                self!.listenYoutubeButton.titleLabel!.text = "Not Available"
            }
        }
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
                    self.startingImageView.image = image
                }
            }
        }.resume()
    }
    
    @IBAction func addFavouritesAction(_ sender: Any) {
        
    }
    
    @IBAction func listenSpotifyAction(_ sender: Any) {
        if spotifyLink?.isEmpty == false {
            UIApplication.shared.openURL(NSURL(string: spotifyLink!)! as URL)
        }
    }
    
    @IBAction func listenYoutubeAction(_ sender: Any) {
        if youtubeLink?.isEmpty == false {
            UIApplication.shared.openURL(NSURL(string: youtubeLink!)! as URL)
        }
    }
    
    
    @IBAction func specAction(_ sender: Any) {
        UIView.transition(with: specsView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.specsView.isHidden = false
        })
    }
    
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .up {
            UIView.transition(with: specsView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.specsView.isHidden = false
            })
       }
       else if gesture.direction == .down {
           UIView.transition(with: specsView, duration: 0.5, options: .transitionCrossDissolve, animations: {
               self.specsView.isHidden = true
           })

       }
    }
    
}
