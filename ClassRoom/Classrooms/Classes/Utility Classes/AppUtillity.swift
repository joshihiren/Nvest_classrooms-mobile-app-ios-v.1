//
//  AppUtillity.swift
//  ClassRoom
//
//  Created by Shorupan Pirakaspathy on 2020-03-27.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit

@objc class AppUtillity: NSObject {
    static let shared = AppUtillity()
    
    @objc class var swiftSharedInstance: AppUtillity {
        struct Singleton {
            static let instance = AppUtillity()
        }
        return Singleton.instance
    }
    
    // the sharedInstance class method can be reached from ObjC
    @objc class func sharedInstance() -> AppUtillity {
        return AppUtillity.swiftSharedInstance
    }
    
    @objc func Getheader() -> [String : String] {
        let header : [String : String] = ["Content-Type":"application/json"]
        return header
    }
    
    @objc public func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat.removeWhiteSpace())
        return emailPredicate.evaluate(with: enteredEmail.removeWhiteSpace())
    }
    
    @objc public func validatePhoneNumber(number:String) -> Bool{
        if number.count < 10
        {
            return false;
        }else{
            return true;
        }
    }
    @objc public func isObjectNotNil(object:AnyObject!) -> Bool
    {
        if let _:AnyObject = object
        {
            return true
        }
        return false
    }
    
    @objc public func NetworkIndicator(status: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = status
//            UserUtility.getRootViewcontroller().view.isUserInteractionEnabled = !status
        }
    }
    
}

struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {

        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {

        self.lockOrientation(orientation)

        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }

}
