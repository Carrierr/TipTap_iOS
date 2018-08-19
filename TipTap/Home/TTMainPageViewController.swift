//
//  TTMainPageViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 15..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTMainPageViewController: UIPageViewController {

    fileprivate var isAbleScrollPage = false
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newTipTapViewController(index:0),
                self.newTipTapViewController(index:1),
                self.newTipTapViewController(index:2)]
    }()
    
    
    private func newTipTapViewController(index: Int) -> UIViewController {
        switch index {
        case 0:
            return TTMyDiaryWireFrame.createModule()
        case 1:
            return UIStoryboard(name: "Main", bundle: nil) .
                instantiateViewController(withIdentifier:"second")
        case 2:
            return UIStoryboard(name: "SharedDiary", bundle: nil) .
                instantiateViewController(withIdentifier:"TTSharedViewController")
        default:
            return UIStoryboard(name: "Main", bundle: nil) .
                instantiateViewController(withIdentifier: "first")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIBinding()
        setTipTapPageViewController()
        addObserver()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func UIBinding(){
        dataSource = self
        delegate   = self
    }
    
    
    private func setTipTapPageViewController(){
        let mainViewController = orderedViewControllers[1]
        DispatchQueue.main.async {

            
            self.setViewControllers([mainViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    private func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(isAblePaging), name: Notification.Name.IsAblePaging.changedAblePaging, object: nil)
    }
    
    @objc private func isAblePaging(){
        self.isPagingEnabled  = true
        self.isAbleScrollPage = true
    }
}

extension TTMainPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of:viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        guard orderedViewControllers.count > previousIndex else { return nil }
        

        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of:viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else { return nil }
        guard orderedViewControllersCount > nextIndex else { return nil }
        
        
        
        return orderedViewControllers[nextIndex]
    }
}

extension TTMainPageViewController : UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let vc = pageViewController.viewControllers?.first else { return }
        guard let viewControllerIndex = orderedViewControllers.index(of:vc) else { return }
        
        
        if viewControllerIndex == 2 {
            pageViewController.isPagingEnabled = isAbleScrollPage
        }
    }
}


