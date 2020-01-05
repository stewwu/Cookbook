//
//  LoopedCarouselViewController.swift
//  Cookbook
//
//  Created by Ching on 2020/1/1.
//  Copyright © 2020 Che-Ching Wu. All rights reserved.
//

import UIKit

class LoopedCarouselViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    var ads = [#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
    var cellWidth: CGFloat {
        return collectionView.frame.width - 15 * 2
    }
    var beginOffset = CGPoint(x: 0, y: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.bounces = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: UICollectionViewCell.self))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        collectionView.contentOffset.x = CGFloat(ads.count) * cellWidth - 15
    }
}

extension LoopedCarouselViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ads.count * 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UICollectionViewCell.self), for: indexPath)
        cell.backgroundColor = ads[indexPath.item % ads.count]
        return cell
    }
}

extension LoopedCarouselViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: collectionView.frame.height)
    }
}

extension LoopedCarouselViewController: UIScrollViewDelegate {

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
            }
        } else if beginOffset.x - endOffset.x > cellWidth / 2 {
            if endOffset.x > 0 {
                endOffset.x = floor(endOffset.x / cellWidth) * cellWidth - 15
                scrollView.setContentOffset(endOffset, animated: true)
            }
        } else {
            scrollView.setContentOffset(beginOffset, animated: true)
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let centerX = collectionView.contentOffset.x + collectionView.frame.width / 2
        let item = Int(centerX / cellWidth)
        if item >= ads.count * 2 {
            collectionView.scrollToItem(at: IndexPath(item: item - ads.count, section: 0), at: .centeredHorizontally, animated: false)
        } else if item < ads.count {
            collectionView.scrollToItem(at: IndexPath(item: item + ads.count, section: 0), at: .centeredHorizontally, animated: false)
        }
    }
}
