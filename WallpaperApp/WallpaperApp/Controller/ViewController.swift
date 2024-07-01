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
    }
    
    var selectedTab: FooterTab = .home
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchViewController(selectedTab: .home)
        }
    
    
    private lazy var homeCollectionViewController: HomeCollectionViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "HomeCollectionViewController") as! HomeCollectionViewController
        add(childViewController: viewController)
        return viewController
    }()
    
    private func switchViewController(selectedTab: FooterTab) {
        switch selectedTab {
        case .home:
            add(childViewController: homeCollectionViewController)
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
