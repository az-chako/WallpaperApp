//
//  DetailViewController.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/06/25.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var pictureImg:UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var updateDate: UILabel!
    var imageUrlString: String?
    var unsplashImage: UnsplashImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()
        setupLabels()
        setupTapGesture()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        if let alternativeSlug = unsplashImage?.alternativeSlugs?.ja {
            self.title = alternativeSlug
        }
    }
    
    func setupImage() {
        pictureImg.contentMode = .scaleAspectFill
        pictureImg.clipsToBounds = true
        
        if let imageUrlString = unsplashImage?.urls.regular,
           let imageUrl = URL(string: imageUrlString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        self.pictureImg.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
    
    func setupLabels() {
        guard let user = unsplashImage?.user else {
            return
        }
        
        authorName.text = user.name
        authorName.isUserInteractionEnabled = true
        authorName.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openAuthorLink)))
        
        if let location = user.location {
            country.text = location
            country.isHidden = false
        } else {
            country.text = "Location not provided"
            country.isHidden = false
        }
        
        
        if let updatedAt = unsplashImage?.updatedAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = dateFormatter.date(from: updatedAt) {
                dateFormatter.dateFormat = "yyyy年MM月dd日"
                updateDate.text = dateFormatter.string(from: date)
            }
        }
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        pictureImg.isUserInteractionEnabled = true
        pictureImg.addGestureRecognizer(tapGesture)
    }
    
    @objc func imageTapped() {
        performSegue(withIdentifier: "showPicture", sender: nil)
    }
    
    @objc func openAuthorLink() {
        if let username = unsplashImage?.user.username,
           let url = URL(string: "https://unsplash.com/ja/@\(username)") {
            let webViewController = WebViewController(url: url)
            let navigationController = UINavigationController(rootViewController: webViewController)
            present(navigationController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPicture" {
            if let showPictureVC = segue.destination as? ShowPictureViewController {
                showPictureVC.image = pictureImg.image
            }
        }
    }
}
