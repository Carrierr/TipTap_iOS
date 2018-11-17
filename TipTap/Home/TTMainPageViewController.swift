//
//  TTMainPageViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 15..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTMainPageViewController: UIPageViewController, TTCanSetupNavigation {
    
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newTipTapViewController(index:0),
                self.newTipTapViewController(index:1),
                self.newTipTapViewController(index:2)]
    }()
    
    private var firstVC      : TTMyDiaryViewController?
    private var secondVC : TTTodayDiaryViewController?
    private var thirdVC     : TTSharedViewController?
    private func newTipTapViewController(index: Int) -> UIViewController {
        switch index {
        case 0:
            if  firstVC == nil {
                firstVC = TTMyDiaryWireFrame.createModule()
            }
            return firstVC!
        case 1:
            if  secondVC == nil {
                secondVC = UIStoryboard(name: "Main", bundle: nil) .instantiateViewController(withIdentifier:"second") as? TTTodayDiaryViewController
            }
            return secondVC!
        case 2:
            
            if  thirdVC == nil {
                thirdVC = UIStoryboard(name: "SharedDiary", bundle: nil) .instantiateViewController(withIdentifier:"TTSharedViewController") as? TTSharedViewController
            }
            return thirdVC!
        default:
            return UIStoryboard(name: "Main", bundle: nil) .
                instantiateViewController(withIdentifier: "first")
        }
    }
    fileprivate var isAbleScrollPage = false
    var titleLabel : UILabel? = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 100, height: 44.0))
    var rightBarButtonItem : UIBarButtonItem?  = UIBarButtonItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIBinding()
        setTipTapPageViewController()
        addObserver()
        setupNavigation()
        setupTodayDiaryNavigation(diaryCount: 2)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }

    
    private func UIBinding(){
        dataSource = self
        delegate   = self
    }
    
    

    
    
    
    
    private func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(isAblePaging), name: Notification.Name.IsAblePaging.changedAblePaging, object: nil)
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
    
    
    private func setupTodayDiaryNavigation(diaryCount count: Int){
        guard let titleLabel = titleLabel,
        let rightBarButtonItem = rightBarButtonItem else {
            return
        }
        titleLabel.text = "Today\n#\(count)"
        rightBarButtonItem.image = UIImage(named: "setting")?.withRenderingMode(.alwaysOriginal)
        rightBarButtonItem.target = self
        rightBarButtonItem.action = #selector(goSetting)
    }
    
    
    private func setupMyDiaryNavigation(){
        guard let titleLabel = titleLabel,
            let rightBarButtonItem = rightBarButtonItem else {
                return
        }
        titleLabel.text = "MY DIARY"
        rightBarButtonItem.image = UIImage(named: "calendar")?.withRenderingMode(.alwaysOriginal)
        rightBarButtonItem.target = newTipTapViewController(index: 0)
        rightBarButtonItem.action = #selector(TTMyDiaryViewController.pressedCalendar)
    }
    
    
    private func setupSharedDiaryNavigation(diaryCount count: Int){
        guard let titleLabel = titleLabel,
            let rightBarButtonItem = rightBarButtonItem else {
                return
        }
        titleLabel.text = "\(count)\nTIPTAP"
        rightBarButtonItem.image = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        rightBarButtonItem.target = newTipTapViewController(index: 2)
        rightBarButtonItem.action = #selector(TTSharedViewController.showMoreOption)
    }
    
    
    @objc private func goSetting(){
        
    }
    
    
    @objc private func isAblePaging(){
        self.isPagingEnabled  = true
        self.isAbleScrollPage = true
        setupSharedDiaryNavigation(diaryCount: 2)
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
        
        switch viewControllerIndex {
        case 0:
            setupMyDiaryNavigation()
            break
        case 1:
            setupTodayDiaryNavigation(diaryCount: 2)
            break
        case 2:
            if isAbleScrollPage {
                setupSharedDiaryNavigation(diaryCount: 2)
            }else{
                titleLabel?.text = ""
                rightBarButtonItem?.image = UIImage()
                thirdVC?.attachScratchView()
            }
            
            pageViewController.isPagingEnabled = isAbleScrollPage
            break
        default:
            break
        }
    }
}


