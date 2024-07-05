//
//  HomeCollectionViewController.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/06/25.
//
//
import UIKit

private let reuseIdentifier = "CustomCell"
private let accessKey = "2t1vdj2pJ7IJmMz_1os77S5M5SlnjKvCpIn8yHg0vlI"

class HomeCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.alwaysBounceVertical = true
            collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            
//            collectionView.register(UINib(nibName: "SectionHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        }
    }
    
    var images: [UnsplashImage] = []
    
    // Label to display "新着写真"
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "新着写真"
            label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add title label to the view
            view.addSubview(titleLabel)
            setupTitleLabelConstraints()
            
            let layout = CustomLayout()
            collectionView.setCollectionViewLayout(layout, animated: false)
            
            // Adjust collection view content inset
            collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
            
            fetchImages()
    }
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
//        header.configure(title: "新着写真")
//        return header
//        }
//
    

    
    func fetchImages() {
        let urlString = "https://api.unsplash.com/photos/?per_page=5&order_by=latest&client_id=\(accessKey)"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                self.images = try decoder.decode([UnsplashImage].self, from: data)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                // エラーハンドリング
            }
        }
        task.resume()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let imageUrlString = images[indexPath.item].urls.regular
        if let imageUrl = URL(string: imageUrlString) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        cell.imageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        cell.nameLabel.text = images[indexPath.item].user.name
        
        if indexPath.item == 0 {
            cell.imageView.layer.cornerRadius = 9
        } else {
            cell.imageView.layer.cornerRadius = 6
        }
        
        cell.imageView.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = images[indexPath.item]
        performSegue(withIdentifier: "showDetail", sender: selectedImage)
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
