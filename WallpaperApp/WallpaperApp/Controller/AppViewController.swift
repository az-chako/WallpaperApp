//
//  AppViewController.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/07/03.
//

import UIKit
import SafariServices

class AppViewController: UIViewController {
    
    @IBOutlet weak var logo: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ロゴにタップジェスチャーを追加
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(logoTapped))
        logo.addGestureRecognizer(tapGesture)
        logo.isUserInteractionEnabled = true
    }
    
    @objc func logoTapped() {
        if let url = URL(string: "https://unsplash.com/ja") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}
