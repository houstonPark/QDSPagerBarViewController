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
}

extension QDSPagerViewController: UIPageViewControllerDelegate {
    
}

extension QDSPagerViewController: UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return nil
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        return 0
    }
    
}

class QDSPagerUIPageViewController: UIPageViewController { }
