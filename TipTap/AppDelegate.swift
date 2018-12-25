//
//  AppDelegate.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 15..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit
import UserNotifications

import KakaoOpenSDK
import SnapKit


let appDelegate = UIApplication.shared.delegate as? AppDelegate
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, TTTimeGettable{

    var window                      : UIWindow?
    var loginViewController         : UIViewController?
    var mainViewController          : UIViewController?
    var firstDescriptViewController : UIViewController?
    var loadingView : UIView? 

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        KOSession.shared().isAutomaticPeriodicRefresh = true
        setupEntryController()
        
        // 로그인,로그아웃 상태 변경 받기
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AppDelegate.sessionDidChangeWithNotification),
                                               name: NSNotification.Name(rawValue: "sessionDidChange"),
                                               object: nil)
        
        
        
        reloadRootViewController()
        return true
    }

    
    fileprivate func setupEntryController() {
        let loginStoryboard = UIStoryboard(name: "TTLogin", bundle: nil)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let descriptStoryboard = UIStoryboard(name: "TTFirstDescriptViewController", bundle: nil)

        
        let viewController = loginStoryboard.instantiateViewController(withIdentifier: "TTLoginViewController") as UIViewController
        let viewController2 = mainStoryboard.instantiateViewController(withIdentifier: "TTMainPageViewController") as UIViewController
        let viewController3 = descriptStoryboard.instantiateViewController(withIdentifier: "TTDescriptMainViewController") as UIViewController
        
        
        self.loginViewController         = viewController
        self.mainViewController          = viewController2
        self.firstDescriptViewController = viewController3
    }
    
    
    fileprivate func reloadRootViewController() {
        let isOpened = KOSession.shared().isOpen()
        var launchVC : UIViewController?
        if TTDeviceInfo.SettingInfo.isFirstLaunch {
            launchVC = firstDescriptViewController
        }else{
            launchVC = mainViewController
        }

        self.window?.rootViewController = isOpened ?  launchVC!  : UINavigationController(rootViewController: self.loginViewController!)
        self.window?.makeKeyAndVisible()
    }
    
    
    
    @objc func sessionDidChangeWithNotification() {
        reloadRootViewController()
    }
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if KOSession.handleOpen(url) {
            return true
        }
        return false
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        if KOSession.handleOpen(url) {
            return true
        }
        return false
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        KOSession.handleDidEnterBackground()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        KOSession.handleDidBecomeActive()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    //MARK: Local Notification
    func registerLocalNoti(){
        let content = UNMutableNotificationContent()
//        content.title = "제목"
//        content.subtitle = "소제목"
        content.body = "오늘의 tiptap이 1시간 후에 마감됩니다."
        
        if #available(iOS 12.0, *) {
            content.summaryArgument = "TIPTAP"
            content.summaryArgumentCount = 40
        }
        
//        let timeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        
        let dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: getMidnight())
        let calendartrigger = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: false)
        let request = UNNotificationRequest(identifier: "notiDoneTodayDiary", content: content, trigger: calendartrigger)
        
        print("\( getMidnight())")
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func unregisterLocalNoti(){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["notiDoneTodayDiary"])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        print("openSettingsFor")
    }
    
    
    
    //MARK: Login & Logout
    func logout(){
        KOSession.shared()?.logoutAndClose(completionHandler: { (success, error) in
            let loginVC = UIStoryboard(name: "TTLogin", bundle: nil).instantiateViewController(withIdentifier: "TTLoginViewController") as UIViewController
            appDelegate?.window?.rootViewController = UINavigationController(rootViewController: loginVC)
            UserDefaults.standard.removeObject(forKey: "tokenID")
        })
    }

    
    //MARK: Search Front View Controller
    func searchFrontViewController(_ viewController : UIViewController)->UIViewController{
        var vc = viewController
        if let presentVC = viewController.presentedViewController {
            vc = self.searchFrontViewController(presentVC)
        }
        
        return vc
    }
    
    
    
    func searchFrontViewController()->UIViewController{
        var vc = appDelegate?.window?.rootViewController
        vc = self.searchFrontViewController(vc!)
        return vc!
    }
    
    
    //MARK: Loading View
    func showLoadingVIew(){
        let parentView = appDelegate?.searchFrontViewController().view
        makeLoadingView(parentView: parentView!)
        
        guard let loadingView = self.loadingView else { return }
        parentView?.bringSubview(toFront: loadingView)
        loadingView.isHidden = false
        loadingView.alpha = 0.1
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIView.animate(withDuration: 0.3) {
                loadingView.alpha = 1
        }
    }
    
    
    func hideLoadingView(){
        guard let loadingView = self.loadingView else { return }
        UIView.animate(withDuration: 0.5, animations: {
            loadingView.alpha = 0
        }) { (finished) in
            loadingView.isHidden = true
            UIApplication.shared.endIgnoringInteractionEvents()
            self.loadingView = nil
        }
    }
    
    
    private func makeLoadingView(parentView : UIView){
        self.loadingView = UIView()
        
        let indicatorView = UIActivityIndicatorView()
        let backgroundView = UIView()
        guard let loadingView = self.loadingView else { return }
        
        parentView.addSubview(loadingView)
        loadingView.addSubview(backgroundView)
        loadingView.addSubview(indicatorView)
        
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        
        backgroundView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        indicatorView.activityIndicatorViewStyle = .whiteLarge
        indicatorView.startAnimating()
    }
}

