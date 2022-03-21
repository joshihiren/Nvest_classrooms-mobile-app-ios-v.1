//
//  AppDelegate.swift
//  ClassRoom
//
//  Created by Shorupan Pirakaspathy on 2020-04-07.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SVGKit
import CRNotifications


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let window: UIWindow = {
        let w = UIWindow()
        w.backgroundColor = .white
        w.makeKeyAndVisible()
        return w
    }()
    var orientationLock = UIInterfaceOrientationMask.all
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //        IQKeyboardManager.shared.enable = true
        //        IQKeyboardManager.shared.enableAutoToolbar = true
        //        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        
        #if Dev_DEBUG || Dev_RELEASE
        print("Dev")
        #elseif UAT_DEBUG || UAT_RELEASE
        print("UAT")
        #elseif QA_DEBUG || QA_RELEASE
        print("QA")
        #else
        print("Prod")
        #endif
        
        self.GetinitialView()
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
}

extension AppDelegate {
    
    @objc public func GetinitialView() {
        let userinfo = UserInfoData.shared.GetUserInfodata()
        if userinfo == nil || userinfo!.accessToken.count == 0 {
            self.SetLoginVC()
        }
        else {
            self.SetDashboardVC()
        }
    }
    
    @objc public func SetDashboardVC() {
        let vc = loadViewController("Main", "TabBarVC")
        let navigationController = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        navigationController.setNavigationBarHidden(true, animated: false)
        self.window.backgroundColor = UIColor.white
    }
    
    @objc public func SetLoginVC() {
        let vc = LoginVC.init(nibName: "LoginVC", bundle: nil)
        let navigationController = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        navigationController.setNavigationBarHidden(true, animated: false)
        self.window.backgroundColor = UIColor.white
    }
    
    @objc public func getCourceTab() -> BubbleTabBarController {
        let tabBarController = BubbleTabBarController()
        let cource = MyCourceVC.init(nibName: "MyCourceVC", bundle: nil)
        cource.tabBarItem = UITabBarItem(title: "My Cources", image: UIImage.init(named: "HomeTab"), tag: 0)
        let searchVC = SearchTabVC.init(nibName: "SearchTabVC", bundle: nil)
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage.init(named: "Search"), tag: 1)
        let profile = ProfileTabVC.init(nibName: "ProfileTabVC", bundle: nil)
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage.init(named: "ProfileTab"), tag: 2)

        tabBarController.viewControllers = [cource, searchVC, profile]
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.2549019608, green: 0.2823529412, blue: 0.3960784314, alpha: 1)
        return tabBarController
    }
    
}
