//
//  SmallBannerViewController.swift
//  Cookbook
//
//  Created by Ching on 2020/1/2.
//  Copyright © 2020 Che-Ching Wu. All rights reserved.
//

import UIKit

class PagedSmallBannerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var ads = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)]
    var cellWidth: CGFloat {
        return collectionView.frame.width - 30
    }
    var beginOffset = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
    }

}

extension PagedSmallBannerViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
        cell.backgroundColor = ads[indexPath.item]
        return cell
    }
}

extension PagedSmallBannerViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: collectionView.frame.height)
    }
}

extension PagedSmallBannerViewController: UIScrollViewDelegate {

    // 減速動畫有不同速率
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        if targetContentOffset.pointee.x >= scrollView.contentOffset.x && scrollView.contentOffset.x > 0 {
//            var targetItem = Int(targetContentOffset.pointee.x / cellWidth)
//            if targetContentOffset.pointee.x > (CGFloat(targetItem) + 0.5) * cellWidth {
//                targetItem += 1
//            }
//            if targetItem >= collectionView.numberOfItems(inSection: 0) - 1 {
//                targetContentOffset.pointee.x = scrollView.contentSize.width - collectionView.frame.width
//            } else {
//                targetContentOffset.pointee.x = cellWidth * CGFloat(targetItem)
//            }
//        } else {
//            let targetItem = Int(targetContentOffset.pointee.x / cellWidth)
//            if targetItem == 0 {
//                targetContentOffset.pointee.x = 0
//            } else {
//                targetContentOffset.pointee.x = cellWidth * CGFloat(targetItem + 1)
//            }
//        }
//    }

    // 減速動畫有不同速率，同時最多只捲動一筆
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        if targetContentOffset.pointee.x >= scrollView.contentOffset.x && scrollView.contentOffset.x > 0 {
//            let targetItem = Int(scrollView.contentOffset.x / cellWidth) + 1
//
//            if targetItem >= collectionView.numberOfItems(inSection: 0) - 1 {
//                targetContentOffset.pointee.x = scrollView.contentSize.width - collectionView.frame.width
//            } else {
//                targetContentOffset.pointee.x = cellWidth * CGFloat(targetItem)
//            }
//        } else {
//            let targetItem = Int(scrollView.contentOffset.x / cellWidth) - 1
//            targetContentOffset.pointee.x = cellWidth * CGFloat(targetItem + 1)
//        }
//    }

    // 減速動畫類似系統的 paging
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        beginOffset = scrollView.contentOffset
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewWillBeginDecelerating(scrollView)
        }
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        var endOffset = scrollView.contentOffset
        if endOffset.x - beginOffset.x > cellWidth / 2 {
            if endOffset.x + cellWidth * 2 < scrollView.contentSize.width {
                endOffset.x = beginOffset.x + cellWidth
                scrollView.setContentOffset(endOffset, animated: true)
            } else {
                endOffset.x = scrollView.contentSize.width - scrollView.frame.width
                scrollView.setContentOffset(endOffset, animated: true)
            }
        } else if beginOffset.x - endOffset.x > cellWidth / 2 {
            if endOffset.x > 0 {
                endOffset.x = floor(endOffset.x / cellWidth) * cellWidth
                scrollView.setContentOffset(endOffset, animated: true)
            } else {
                endOffset.x = 0
                scrollView.setContentOffset(endOffset, animated: true)
            }
        } else {
            scrollView.setContentOffset(beginOffset, animated: true)
        }
    }
}
