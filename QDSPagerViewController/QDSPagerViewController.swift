//
//  QDSPagerViewController.swift
//  QDSPagerViewController
//
//  Created by Houston Park on 2022/04/25.
//

import UIKit

protocol QDSPagerDelegate: NSObject {
    
    /// Parger Tab CollectionView Height
    var pagerTabHeight: CGFloat { get }
    
    /// Child pager viewControllers
    var uiViewControllers: [UIViewController] { get }
    
    /// PagerButton Background Color
    var pagerButtonBackgroundColor: UIColor { get }
    
    /// PagerButton Text Color
    var pagerButtonTextColor: UIColor { get }
    
    /// Pager Underbar Indicator height
    var pagerUnderbarIndicatorHeight: CGFloat { get }
    
    /// Pager Underbar Indicator Color
    var pagerUnderbarIndicatorColor: UIColor { get }
    
}

open class QDSPagerViewController: UIViewController {
    
    @IBOutlet weak var pagerCollectionView: UICollectionView!
    @IBOutlet weak var pagerContainerView: UIView!
    @IBOutlet weak var pagerCollectionViewHeight: NSLayoutConstraint!
    
    private weak var qdsPagerDelegate : QDSPagerDelegate?
    
    private weak var pageViewController: QDSPagerUIPageViewController?
    
    private var currentIndex: Int = 0
    
    init(delegate: QDSPagerDelegate) {
        super.init(nibName: "QDSPagerViewController", bundle: nil)
        self.qdsPagerDelegate = delegate
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ContainerPagerSegue" {
            let pageVC = segue.destination as! QDSPagerUIPageViewController
            pageVC.delegate = self
            pageVC.didMove(toParent: self)
            self.pageViewController = pageVC
        }
    }
    
    private func setupUI() {
        self.setupPagerTabHeight()
    }
    
    private func setupPagerTabHeight() {
        if let qdsPagerDelegate = qdsPagerDelegate, qdsPagerDelegate.uiViewControllers.count != 1 {
            self.pagerCollectionViewHeight.constant = qdsPagerDelegate.pagerTabHeight
        }
        else {
            self.pagerCollectionViewHeight.constant = 0
        }
    }
    
    private func initPageViewController() {
        
    }
    
    private func updateUI(targetIndex: Int) {
        if targetIndex == currentIndex { return }
        let direction: UIPageViewController.NavigationDirection = currentIndex < targetIndex ? .forward : .reverse
        guard let viewController = qdsPagerDelegate?.uiViewControllers[targetIndex] else { return }
        self.pageViewController?.setViewControllers([viewController], direction: direction, animated: true)
    }
}

extension QDSPagerViewController: UIPageViewControllerDelegate {
    
}

//MARK: - CollectionViewDelegate
extension QDSPagerViewController: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.updateUI(targetIndex: indexPath.row)
    }
}

class QDSPagerUIPageViewController: UIPageViewController { }
