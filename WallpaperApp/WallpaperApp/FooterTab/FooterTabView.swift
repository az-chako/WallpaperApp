//
//  FooterTabView.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/07/01.
//

import UIKit

enum FooterTab {
    case home
    case tag
    case app
}

protocol FooterTabViewDelegate: AnyObject {
    func footerTabView(_ footerTabView: FooterTabView, didselectTab: FooterTab)
}

class FooterTabView: UIView {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    var delegate: FooterTabViewDelegate?
    
    @IBAction func didTapHome(_ sender: Any) {
        delegate?.footerTabView(self, didselectTab: .home)
    }
    @IBAction func didTapTag(_ sender: Any) {
        delegate?.footerTabView(self, didselectTab: .tag)
    }
    @IBAction func didTapApp(_ sender: Any) {
        delegate?.footerTabView(self, didselectTab: .app)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        load()
        setup()
    }
    
    func setup() {
        // 楕円形にする
        contentView.layer.cornerRadius = contentView.frame.height / 2
        contentView.layer.masksToBounds = true
        
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        shadowView.layer.shadowRadius = 4
        shadowView.layer.masksToBounds = false
        shadowView.layer.cornerRadius = 10
    }
    
    func load() {
        if let view = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self,options: nil)?.first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
}

