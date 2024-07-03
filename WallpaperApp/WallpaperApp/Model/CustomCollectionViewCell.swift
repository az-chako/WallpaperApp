//
//  CustomCollectionViewCell.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/06/25.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let nameLabelContainer = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // ImageViewの設定
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // NameLabelContainerの設定
        nameLabelContainer.backgroundColor = UIColor.white
        nameLabelContainer.layer.cornerRadius = 15
        nameLabelContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        nameLabelContainer.clipsToBounds = true
        contentView.addSubview(nameLabelContainer)
        nameLabelContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabelContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabelContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6)
        ])
        
        // NameLabelの設定
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .right
        nameLabelContainer.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.trailingAnchor.constraint(equalTo: nameLabelContainer.trailingAnchor, constant: -15),
            nameLabel.bottomAnchor.constraint(equalTo: nameLabelContainer.bottomAnchor, constant: -6),
            nameLabel.topAnchor.constraint(equalTo: nameLabelContainer.topAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(equalTo: nameLabelContainer.leadingAnchor, constant: 15)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
