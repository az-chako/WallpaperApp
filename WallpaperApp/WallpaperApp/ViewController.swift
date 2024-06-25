//
//  ViewController.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/06/25.
//

import UIKit

class CustomTabBarController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tabButton1: UIButton!
    @IBOutlet weak var tabButton2: UIButton!
    // 他のタブボタンも同様に接続

    private var currentViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTab(at: 0) // 初期タブを設定
    }

    @IBAction func tabButtonTapped(_ sender: UIButton) {
        switch sender {
        case tabButton1:
            setupTab(at: 0)
        case tabButton2:
            setupTab(at: 1)
        // 他のタブも同様に処理
        default:
            break
        }
    }

    private func setupTab(at index: Int) {
        // 現在のViewControllerを削除
        currentViewController?.remove()

        // 新しいViewControllerを追加
        let newViewController: UIViewController
        switch index {
        case 0:
            newViewController = // 1番目のViewControllerをインスタンス化
        case 1:
            newViewController = // 2番目のViewControllerをインスタンス化
        // 他のケースも同様に処理
        default:
            return
        }

        addChild(newViewController)
        contentView.addSubview(newViewController.view)
        newViewController.view.frame = contentView.bounds
        newViewController.didMove(toParent: self)

        currentViewController = newViewController
    }
}

extension UIViewController {
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
