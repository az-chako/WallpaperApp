//
//  DetailViewController.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/06/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var pictureImg:UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var UpdateDate: UILabel!
    var imageUrlString: String?

        override func viewDidLoad() {
            super.viewDidLoad()

            // UIImageViewのアスペクト比を1:1に設定
            pictureImg.contentMode = .scaleAspectFill
            pictureImg.clipsToBounds = true

            if let imageUrlString = imageUrlString, let imageUrl = URL(string: imageUrlString) {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: imageUrl) {
                        DispatchQueue.main.async {
                            self.pictureImg.image = UIImage(data: imageData)
                        }
                    }
                }
            }

            // タップジェスチャーを追加
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            pictureImg.isUserInteractionEnabled = true
            pictureImg.addGestureRecognizer(tapGesture)
        }

        @objc func imageTapped() {
            performSegue(withIdentifier: "showPicture", sender: nil)
        }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showPicture" {
                if let showPictureVC = segue.destination as? ShowPictureViewController {
                    showPictureVC.image = pictureImg.image
                }
            }
        }
    }
