//
//  TagViewController.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/07/01.
//

import UIKit

class TagViewController: UIViewController {
    
    private let unsplashService = UnsplashService()
    private var images: [UnsplashImage] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var whiteButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setupCollectionView()
            setupButtons()
            fetchImagesForColor(Color.red)
        }
        
        private func setupCollectionView() {
            let layout = CustomLayout()
            collectionView.collectionViewLayout = layout
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.alwaysBounceVertical = true 
            collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        }
        
        private func setupButtons() {
            let buttons = [redButton, blueButton, greenButton, yellowButton, whiteButton, blackButton]
            buttons.forEach { button in
                button?.addTarget(self, action: #selector(tagButtonTapped(_:)), for: .touchUpInside)
            }
        }
        
        @IBAction func tagButtonTapped(_ sender: UIButton) {
            guard let color = sender.titleLabel?.text?.lowercased() else { return }
            fetchImagesForColor(color)
        }
        
        private func fetchImagesForColor(_ color: String) {
            unsplashService.fetchImages(forColor: color) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let fetchedImages):
                    DispatchQueue.main.async {
                        self.images = fetchedImages
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    print("Failed to fetch images for color: \(color). Error: \(error)")
                }
            }
        }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let detailVC = segue.destination as? DetailViewController,
               let selectedImage = sender as? UnsplashImage {
                detailVC.unsplashImage = selectedImage
                }
            }
        }
    }

    extension TagViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return images.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCollectionViewCell else {
                fatalError("Failed to dequeue CustomCollectionViewCell")
            }
            
            let image = images[indexPath.item]
            if let imageUrl = URL(string: image.urls.regular) {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: imageUrl) {
                        DispatchQueue.main.async {
                            cell.imageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }
            
            cell.nameLabel.text = image.user.name
            
            if indexPath.item == 0 {
                cell.imageView.layer.cornerRadius = 9
            } else {
                cell.imageView.layer.cornerRadius = 6
            }
            
            return cell
        }

        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedImage = images[indexPath.item]
            performSegue(withIdentifier: "showDetail", sender: selectedImage)
        }
    }
