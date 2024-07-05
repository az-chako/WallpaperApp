//
//  CustomLayout.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/06/25.
//

import UIKit

class CustomLayout: UICollectionViewLayout {
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()
    private var contentSize: CGSize = .zero
    private let bottomPadding: CGFloat = 200

    override func prepare() {
        guard let collectionView = collectionView else { return }

        layoutAttributes.removeAll()

        let width = collectionView.bounds.width
        var yOffset: CGFloat = 0

        let largeItemSize = CGSize(width: 360, height: 360)
        let largeItemIndexPath = IndexPath(item: 0, section: 0)
        let largeItemAttributes = UICollectionViewLayoutAttributes(forCellWith: largeItemIndexPath)
        largeItemAttributes.frame = CGRect(x: (width - largeItemSize.width) / 2, y: yOffset, width: largeItemSize.width, height: largeItemSize.height)
        layoutAttributes.append(largeItemAttributes)
        
        yOffset += largeItemSize.height + 18

        let smallItemSize = CGSize(width: 171, height: 171)
        let padding: CGFloat = 18
        let sidePadding: CGFloat = (width - (smallItemSize.width * 2) - padding) / 2
        for i in 1..<5 {
            let indexPath = IndexPath(item: i, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let xOffset = sidePadding + CGFloat((i - 1) % 2) * (smallItemSize.width + padding)
            attributes.frame = CGRect(x: xOffset, y: yOffset + CGFloat((i - 1) / 2) * (smallItemSize.height + padding), width: smallItemSize.width, height: smallItemSize.height)
            layoutAttributes.append(attributes)
        }

        let totalHeight = yOffset + smallItemSize.height * 2 + padding + bottomPadding
        contentSize = CGSize(width: width, height: totalHeight)
        
    }

    override var collectionViewContentSize: CGSize {
        return contentSize
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter { $0.frame.intersects(rect) }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes.first { $0.indexPath == indexPath }
    }
}
