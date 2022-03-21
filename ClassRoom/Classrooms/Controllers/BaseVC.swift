//
//  BaseVC.swift
//  ClassRoom
//
//  Created by Shorupan Pirakaspathy on 2020-04-02.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit

class BaseVC: UIViewController, UIGestureRecognizerDelegate {
    
    //    MARK:- Variable Defines
    
    //    MARK:- Life Cycle Define
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        //        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.backBarButtonItem?.tintColor = .white
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        self.view.theme_backgroundColor = GlobalPicker.backgroundColor
        
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedsStatusBarAppearanceUpdate()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(DoneBTNAction))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func DoneBTNAction () {
        self.view.endEditing(true)
    }
    
}

extension UIViewController {
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            return true
        } else if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        } else {
            return false
        }
    }
}
