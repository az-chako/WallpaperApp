//
//  ViewController.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/06/28.
//

import UIKit

class ViewController: UIViewController, FooterTabViewDelegate {
    
    @IBOutlet weak var footerTabView: FooterTabView! {
        didSet {
            footerTabView.delegate = self
        }
    }
    
    func footerTabView(_ footerTabView: FooterTabView, didselectTab tab: FooterTab) {
        switchViewController(selectedTab: tab)
    }
    
    var selectedTab: FooterTab = .home
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchViewController(selectedTab: .home)
    }
    
    private lazy var homeCollectionViewController: HomeCollectionViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeCollectionViewController") as! HomeCollectionViewController
        return viewController
    }()
    
    private lazy var tagViewController: TagViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TagViewController") as! TagViewController
        return viewController
    }()
    
    private lazy var appViewController: AppViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AppViewController") as! AppViewController
        return viewController
    }()
    
    private func switchViewController(selectedTab: FooterTab) {
        // 現在表示中の子ViewControllerを削除
        children.forEach { remove(childViewController: $0) }
        
        switch selectedTab {
        case .home:
            add(childViewController: homeCollectionViewController)
        case .tag:
            add(childViewController: tagViewController)
        case .app:
            add(childViewController: appViewController)
        }
        self.selectedTab = selectedTab
        view.bringSubviewToFront(footerTabView)
    }
    
    private func add(childViewController: UIViewController) {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParent: self)
    }
    
    private func remove(childViewController: UIViewController) {
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }
}
