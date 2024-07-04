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

    var images: [UnsplashImage] = []
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // レイアウトの設定
        let layout = CustomLayout()

        // UICollectionViewの初期化
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
//        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")

        // カスタムセルの登録
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // UICollectionViewをビューに追加
        self.view.addSubview(collectionView)

        // データの取得
        fetchImages()
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

      // 1. ヘッダーセクションを作成
//      guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader else {
//        fatalError("ヘッダーがありません")
//      
//
//     // 2. ヘッダーセクションのラベルにテキストをセット
//     if kind == UICollectionView.elementKindSectionHeader {
//       header.sectionHeader.text = "セクションヘッダー"
//       return header
//    }
//
//     return UICollectionReusableView()
//    }

    // 画像を取得するメソッド
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

    // セクション数を返す
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // セクション内のアイテム数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    // セルを構成する
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

        // 投稿者の名前を設定
        cell.nameLabel.text = images[indexPath.item].user.name

        // 角丸を設定
        if indexPath.item == 0 {
            cell.imageView.layer.cornerRadius = 9
        } else {
            cell.imageView.layer.cornerRadius = 6
        }

        cell.imageView.layer.masksToBounds = true

        return cell
    }

    // セルが選択された時に呼ばれるメソッド
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = images[indexPath.item]
        performSegue(withIdentifier: "showDetail", sender: selectedImage)
    }

    // 遷移先にデータを渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let detailVC = segue.destination as? DetailViewController,
               let selectedImage = sender as? UnsplashImage {
                detailVC.unsplashImage = selectedImage
            }
        }
    }
}
