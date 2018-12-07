//
//  TTDescriptMainViewController.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 10. 30..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit

class TTDescriptMainViewController: UIViewController {
    @IBOutlet private weak var skipButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var pageControl: UIPageControl!
    private var pageViewController : UIPageViewController!
    private var pageIndex = 0{
        didSet{
            if pageIndex == orderedViewControllers.count - 1{
                nextButton.setTitle("시작하기", for: .normal)
            }else{
                nextButton.setTitle("다음으로", for: .normal)
            }
        }
    }
    
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newPageViewController(index:0),
                self.newPageViewController(index:1),
                self.newPageViewController(index:2)]
    }()
    
    
    private lazy var splashImages:[UIImage] = [UIImage(named: "splash01")!,
                                              UIImage(named: "splash02")!,
                                              UIImage(named: "splash03")!,]
    
    
    private lazy var splashTitles:[String] = ["오늘 하루 여행일기를 써보세요!",
                                              "우표를 모으는 재미",
                                              "매일 tiptap을 받아보는 재미"]
    
    
    private lazy var splashContents:[String] = ["단, 24시간이 지나\n일기가 마감되고 나면 수정이 불가합니다.",
                                                "여행지에서 일기를 한 편 쓸 때마다\n우표를 한 개씩 모을 수 있습니다.\n(하루 최대 10개)",
                                                "다른 여행자의 하루 일기를\n받아볼 수 있습니다."]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        setPageViewController(index: 0)
    }
    
    
    
    
    private func setupUI(){
        initNavi()
        self.pageViewController = self.storyboard?.instantiateViewController(withIdentifier: "TTFirstDescriptViewController") as? UIPageViewController
        self.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.view.bringSubview(toFront: pageControl)
        self.view.bringSubview(toFront: nextButton)
        self.view.bringSubview(toFront: skipButton)
        
        
        
        pageControl.numberOfPages = orderedViewControllers.count
        pageControl.currentPage = 0
        
    }
    
    
    
    private func setupBinding(){
        self.pageViewController.dataSource = self
        self.pageViewController.delegate   = self
    }
    
    
    private func initNavi(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    
    
    private func setPageViewController(index : Int){
        guard index < orderedViewControllers.count else { return }
        let mainViewController = orderedViewControllers[index]
        DispatchQueue.main.async {
            self.pageViewController.setViewControllers([mainViewController],
                                    direction: .forward,
                                    animated: true,
                                    completion: nil)
        }
    }
    
    
    
    
    private func newPageViewController(index: Int) -> TTDescriptContentViewController {
        let vc : TTDescriptContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "TTDescriptContentViewController") as! TTDescriptContentViewController
        switch index {
        case 0:
            vc.descriptionImage = splashImages[index]
            vc.descriptionTitle = splashTitles[index]
            vc.descriptionContent = splashContents[index]
            return vc
        case 1:
            vc.descriptionImage = splashImages[index]
            vc.descriptionTitle = splashTitles[index]
            vc.descriptionContent = splashContents[index]
            return vc
        case 2:
            vc.descriptionImage = splashImages[index]
            vc.descriptionTitle = splashTitles[index]
            vc.descriptionContent = splashContents[index]
            return vc
        default:
            break
        }
        return vc
    }
    
    
    private func showMainView(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "TTMainPageViewController") as UIViewController
        self.present(viewController, animated: true) {
            TTDeviceInfo.SettingInfo.isFirstLaunch = false
        }
//        self.present(UINavigationController(rootViewController: viewController), animated: true, completion:{
//            TTDeviceInfo.SettingInfo.isFirstLaunch = false
//        })
    }
    
    
    //MARK : IBAction
    @IBAction func pressedNextButton(_ sender: Any) {
        if nextButton.titleLabel?.text == "다음으로" {
            pageIndex = pageIndex + 1
            pageControl.currentPage = pageIndex
            setPageViewController(index: pageIndex)
        }else{
            showMainView()
        }
    }
    
    @IBAction func pressedSkipButton(_ sender: Any) {
        showMainView()
    }
}



extension TTDescriptMainViewController : UIPageViewControllerDataSource{
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
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}


extension TTDescriptMainViewController : UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let currentPage = orderedViewControllers.index(of:pendingViewControllers[0])
        self.pageIndex = currentPage ?? 0
        self.pageControl.currentPage = currentPage ?? 0
    }
}
