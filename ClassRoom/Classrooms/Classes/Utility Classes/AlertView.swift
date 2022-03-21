//
//  AlertView.swift
//
//  Created by Hiren Joshi on 13/07/19.
//  Copyright © 2019 Hiren Joshi. All rights reserved.
//

import UIKit
import Foundation

@objc public class AlertView: NSObject {
    
    /**
     Call this function for showing alert with OK button in your View Controller class.
     - Parameters:
     - VC : View Controller over which the function is called. You can use self, or provide view controller name.
     - message: Pass your alert message in String.
     - title: Add alertview title
     - okClickHandler: This will give you call back inside block when OK button is clicked
     
     ### Usage Example: ###
     ````
     AlertView.showSingleAlertVC(withTitle: "Reset password!".localized(), withMessage: "Your password reset successfully, please login with new password!!!".localized(), withconfirmbtn: "OK".localized(), withcontroller: self, withTureBlock: {
     self.navigationController?.popToRootViewController(animated: true)
     })
     ````
     */
    // 
    @objc public class func showSingleAlertVC(withTitle title: String?, withMessage message: String?, withconfirmbtn confirm: String?, withcontroller vc: UIViewController, withTureBlock tureBlock: @escaping () -> Void) {
        let atCL = UIAlertController(title: title, message: message, preferredStyle: .alert)
        atCL.addAction(UIAlertAction(title: confirm?.localized(), style: .default, handler: { action in
            atCL.dismiss(animated: true)
            tureBlock()
        }))
        vc.present(atCL, animated: true)
    }
    
    /**
     Call this function for showing alert with OK and Cancel button in your View Controller class.
     - Parameters:
     - VC : View Controller over which the function is called. You can use self, or provide view controller name.
     - message: Pass your alert message in String.
     - title: Add alertview title
     - okClickHandler: This will give you call back inside block when OK button is clicked
     
     ### Usage Example: ###
     ````
     AlertView .showAleartVc(withTitle: "Unable to access the Camera", withMessage: "To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app. Or select photo from Album", withconfirmbtn: "Album".localized(), withcontroller: self, withTureBlock: {
        Do as you wont
     }) {
     
     }
     ````
 */
    
    @objc public class func showAleartVc(withTitle title: String?, withMessage message: String?, withconfirmbtn confirm: String?, withcontroller vc: UIViewController, withTureBlock tureBlock: @escaping () -> Void, withCancelBlock cancelBlock: @escaping () -> Void) {
        let atCL = UIAlertController(title: title, message: message, preferredStyle: .alert)
        atCL.addAction(UIAlertAction(title: confirm?.localized(), style: .default, handler: { action in
            atCL.dismiss(animated: true)
            tureBlock()
        }))
        atCL.addAction(UIAlertAction(title: "Cancel".localized(), style: .destructive, handler: { action in
            atCL.dismiss(animated: true)
            cancelBlock()
        }))
        vc.present(atCL, animated: true)
    }
    
    /**
     Call this function for showing alert with option array in your View Controller class.
     - Parameters:
     - VC : View Controller over which the function is called. You can use self, or provide view controller name.
     - message: Pass your alert message in String.
     - title: Add alertview title
     - option array: all option menu in array
     - okClickHandler: This will give you call back inside block when OK button is clicked
     
     ### Usage Example: ###
     ````
     AlertView.showAlertSheetwith(_ title: String?, message: String?, option: [Any]?, vc: UIViewController, withTureBlock: tureBlock, withCancelBlock: cancelBlock)
     ````
     */
    @objc public class func showAlertSheetwith(_ title: String?, withMessage message: String?, withOption option: [Any]?, withcontroller vc: UIViewController, withTureBlock tureBlock: @escaping (_ str: String?) -> Void, withCancelBlock cancelBlock: @escaping () -> Void) {
        
        let actionSheet = UIAlertController(title: title!.localized(), message: message!.localized(), preferredStyle: .actionSheet)
    
        for str in option! {
            actionSheet.addAction(UIAlertAction(title: (str as! String).localized(), style: .default, handler: { (action) -> Void in
                tureBlock(str as? String)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel".localized(), style: .destructive, handler: { (action) -> Void in
            cancelBlock()
        }))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    /**
     Call this function for showing alert with option array in your View Controller class.
     - Parameters:
     - VC : View Controller over which the function is called. You can use self, or provide view controller name.
     - message: Pass your alert message in String.
     - title: Add alertview title
     - option array: all option menu in array
     - okClickHandler: This will give you call back inside block when OK button is clicked
     
     ### Usage Example: ###
     ````
     AlertView.showAlert(_ title: String?, message: String?, option: [Any]?, vc: UIViewController, withTureBlock: tureBlock, withCancelBlock: cancelBlock)
     ````
     */
    @objc public class func showAlert(_ title: String?, withMessage message: String?, withOption option: [Any]?, Alert Style:
        UIAlertController.Style, withcontroller vc: UIViewController, withTureBlock tureBlock: @escaping (_ str: String?) -> Void, withCancelBlock cancelBlock: @escaping () -> Void) {
        
        let actionSheet = UIAlertController(title: title!.localized(), message: message!.localized(), preferredStyle: Style)
        
        for str in option! {
            actionSheet.addAction(UIAlertAction(title: (str as! String).localized(), style: .default, handler: { (action) -> Void in
                tureBlock(str as? String)
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel".localized(), style: .destructive, handler: { (action) -> Void in
            cancelBlock()
        }))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc public class func showAlertMessage(withMsg: String, withcontroller vc: UIViewController) {
        let alertController = UIAlertController(title: withMsg, message: nil, preferredStyle: .alert)
        vc.present(alertController, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5){
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
