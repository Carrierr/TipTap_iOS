//
//  TTDescriptMainViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 10. 30..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTDescriptMainViewController: UIViewController {
    @IBOutlet private weak var pageControl: UIPageControl!
    private var pageViewController : UIPageViewController!
    private var pageIndex = 0
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newPageViewController(index:0),
                self.newPageViewController(index:1),
                self.newPageViewController(index:2)]
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        setPageViewController()
        
    }
    
    
    
    private func setupUI(){
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "TTFirstDescriptViewController") as? UIPageViewController
        self.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.view.bringSubview(toFront: pageControl)
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
    }
    
    
    
    private func setupBinding(){
        self.pageViewController.dataSource = self
    }
    
    
    
    private func setPageViewController(){
        let mainViewController = orderedViewControllers[0]
        DispatchQueue.main.async {
            self.pageViewController.setViewControllers([mainViewController],
                                    direction: .forward,
                                    animated: true,
                                    completion: nil)
        }
    }
    
    
    
    
    private func newPageViewController(index: Int) -> TTDescriptContentViewController {
        let vc : TTDescriptContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "TTDescriptContentViewController") as! TTDescriptContentViewController
        self.pageIndex = index
        guard let title     = vc.descriptTitleLabel   else { return vc }
        guard let imageView = vc.descriptImageView    else { return vc }
        guard let content   = vc.descriptContentLabel else { return vc }
        
        switch index {
        case 0:
            title.text = "0"
            return vc
        case 1:
            title.text = "1"
            return vc
        case 2:
            title.text = "2"
            return vc
        default:
            break
        }
        
        return vc
    }
}



extension TTDescriptMainViewController : UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = self.pageIndex
        pageControl.currentPage = index
        if( index == 0 || index == NSNotFound) {
            return nil
        }
        index = index - 1
        
        return newPageViewController(index: index)
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.pageIndex
        pageControl.currentPage = index
        if( index == NSNotFound) {
            return nil
        }
        index = index + 1
        
        if (index == orderedViewControllers.count) {
            return nil
        }
        
        return newPageViewController(index: index)
    }
    
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
