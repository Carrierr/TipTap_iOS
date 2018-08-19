//
//  AppDelegate.swift
//  TipTap
//
//  Created by Haehyeon Jeong on 2018. 8. 15..
//  Copyright © 2018년 Tiptap. All rights reserved.
//

import UIKit
import KakaoOpenSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var loginViewController: UIViewController?
    var mainViewController: UIViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        KOSession.shared().isAutomaticPeriodicRefresh = true
        setupEntryController()
        
        // 로그인,로그아웃 상태 변경 받기
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AppDelegate.kakaoSessionDidChangeWithNotification),
                                               name: NSNotification.Name.KOSessionDidChange,
                                               object: nil)
        
        reloadRootViewController()
        return true
    }

    
    fileprivate func setupEntryController() {
        let loginStoryboard = UIStoryboard(name: "TTLogin", bundle: nil)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let navigationController = loginStoryboard.instantiateViewController(withIdentifier: "navigator") as! UINavigationController
        let navigationController2 = loginStoryboard.instantiateViewController(withIdentifier: "navigator") as! UINavigationController

        
        let viewController = loginStoryboard.instantiateViewController(withIdentifier: "TTLoginViewController") as UIViewController
//        navigationController.pushViewController(viewController, animated: true)
        let viewController2 = mainStoryboard.instantiateViewController(withIdentifier: "TTMainPageViewController") as UIViewController
//        navigationController2.pushViewController(viewController2, animated: true)
        
        
        self.loginViewController = viewController
        self.mainViewController = viewController2
    }
    
    
    fileprivate func reloadRootViewController() {
        let isOpened = KOSession.shared().isOpen()
        if !isOpened {
            let mainViewController = self.mainViewController as! UINavigationController
            mainViewController.popToRootViewController(animated: true)
        }
        
        self.window?.rootViewController = isOpened ? UINavigationController(rootViewController: self.mainViewController!)  : UINavigationController(rootViewController: self.loginViewController!)
        self.window?.makeKeyAndVisible()
    }
    
    
    
    @objc func kakaoSessionDidChangeWithNotification() {
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


}

