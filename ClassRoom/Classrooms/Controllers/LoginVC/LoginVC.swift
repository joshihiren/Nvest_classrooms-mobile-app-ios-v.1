//
//  LoginVC.swift
//  ClassRoom
//
//  Created by Shorupan Pirakaspathy on 2020-04-07.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import IHKeyboardAvoiding
import CRNotifications

class LoginVC: BaseVC {

//    MARK:- IBOutlet Define
    @IBOutlet weak var SubMainview: UIView!
    
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet weak var UnderLine: UILabel!
    
    @IBOutlet weak var TXTEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var TXTPassword: SkyFloatingLabelTextField!
    
    @IBOutlet weak var ForgotPassBTN: UIButton!
    @IBOutlet weak var SigninBTN: UIButton!
    
    @IBOutlet weak var LBL1: UILabel!
    @IBOutlet weak var orLBL: UILabel!
    @IBOutlet weak var LBL2: UILabel!
    
    @IBOutlet weak var RegisterBTN: UIButton!
    
    //    MARK:- Variable define
    
//    MARK:- View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

//    MARK:- User Define Methods
    
    func setupView() {
        
//        KeyboardAvoiding.avoidingView = self.TXTEmail
//        KeyboardAvoiding.avoidingView = self.TXTPassword
        
//        self.TXTEmail.text = "mani@nvestbank.com"
//        self.TXTPassword.text = "M@cbeth98"
        
        self.view.theme_backgroundColor = GlobalPicker.backgroundColor
        self.SubMainview.theme_backgroundColor = GlobalPicker.backgroundColor
        
        self.TitleLBL.text = "Sign In"
        self.UnderLine.backgroundColor = AppDarkColor
        
        self.TXTEmail.delegate = self
        self.TXTPassword.delegate = self
        
        self.TXTEmail.placeholder = "Enter GX Email"
        self.TXTEmail.selectedTitle = "Enter GX Email"
        
        self.TXTPassword.selectedTitle = "Password"
        self.TXTPassword.placeholder = "Password"
        self.TXTPassword.isSecureTextEntry = true
        
        self.ForgotPassBTN.setTitle("Forgot Password?", for: .normal)
        self.ForgotPassBTN.setTitleColor(AppDarkColor, for: .normal)
        
        self.SigninBTN.backgroundColor = AppDarkColor
        self.SigninBTN.setTitle("Sign In", for: .normal)
        self.SigninBTN.setTitleColor(.white, for: .normal)
        self.SigninBTN.clipsToBounds = true
        self.SigninBTN.layer.cornerRadius = 10
        
        self.orLBL.text = "or"
        
        self.RegisterBTN.backgroundColor = .clear
        self.RegisterBTN.setTitle("Register", for: .normal)
        self.RegisterBTN.setTitleColor(AppDarkColor, for: .normal)
        self.RegisterBTN.layer.borderColor = AppDarkColor.cgColor
        self.RegisterBTN.layer.borderWidth = 1.0
        self.RegisterBTN.clipsToBounds = true
        self.RegisterBTN.layer.cornerRadius = 10
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(DoneBTNAction))
        tap.cancelsTouchesInView = false
        self.SubMainview.addGestureRecognizer(tap)
        
        let toolbar = UIToolbar.init(frame: CGRect(origin: .zero, size: .init(width: view.frame.width, height: 30)))
        let flexpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBTN = UIBarButtonItem(title: "Done".localized(), style: .done, target: self, action: #selector(DoneBTNAction))
        toolbar.setItems([flexpace, doneBTN], animated: true)
        toolbar.sizeToFit()
        
        self.TXTEmail.inputAccessoryView = toolbar
        self.TXTPassword.inputAccessoryView = toolbar
        
    }
    
//    MARK:- IBAction Methods
    
    @objc override func DoneBTNAction () {
        self.view.endEditing(true)
        self.TXTEmail.resignFirstResponder()
        self.TXTPassword.resignFirstResponder()
    }

    @IBAction func TappedForgotPass(_ sender: Any) {
    }
    
    @IBAction func TappedSignin(_ sender: Any) {
        
        if AppUtillity.shared.validateEmail(enteredEmail: self.TXTEmail.text!.removeWhiteSpace()) {
            self.TXTEmail?.errorMessage = ""
        }
        else {
            self.TXTEmail?.errorMessage = NSLocalizedString(
                "Enter valid email",
                tableName: "",
                comment: ""
            )
            return
        }
        
        if self.TXTPassword.text?.count == 0 || self.TXTPassword.text!.count < 8 {
            self.TXTPassword?.errorMessage = NSLocalizedString(
                "Enter valid password",
                tableName: "",
                comment: ""
            )
            return
        }
        else {
            self.TXTPassword?.errorMessage = ""
        }
        
        let paramDict = LoginParamDict.init(ids: self.TXTEmail.text!.removeWhiteSpace(), password: self.TXTPassword.text!.removeWhiteSpace())
        
        LottieHUD.shared.showHUD()
        NetworkingRequests.shared.NetworkPostrequestJSON(PlistKey.LoginApi, Parameters: paramDict.description, Headers: AppUtillity.shared.Getheader(), onSuccess: { (responseObject, statuscode) in
            if statuscode {
                LottieHUD.shared.stopHUD()
                let userinfo = UserinfoRootClass.init(fromDictionary: responseObject)
                UserInfoData.shared.SaveUserInfodata(info: userinfo)
                App?.SetDashboardVC()
            }
            else {
                LottieHUD.shared.stopHUD()
                let message = responseObject["message"] as AnyObject
                CRNotifications.showNotification(type: CRNotifications.info, title: "INFO!".localized(), message: (message as? String)!, dismissDelay: 3, completion: {
                    
                })
            }
        }) { (msg, code) in
            LottieHUD.shared.stopHUD()
            CRNotifications.showNotification(type: CRNotifications.error, title: "ERROR!".localized(), message: msg, dismissDelay: 3, completion: {
                
            })
        }
    }
    
    @IBAction func TappedRegister(_ sender: Any) {
    }
    
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        if textField == self.TXTEmail {
            if AppUtillity.shared.validateEmail(enteredEmail: (newString as String).removeWhiteSpace()) {
                self.TXTEmail?.errorMessage = ""
            }
            else {
                self.TXTEmail?.errorMessage = NSLocalizedString(
                    "Enter valid email",
                    tableName: "",
                    comment: ""
                )
            }
        }
        else {
//            self.TXTPassword.text!.count >= 8 || self.IsContainUppercase(textvalue: newString as String) || self.IsContainDigit(textvalue: newString as String) || self.IsContainSpecialCharacter(textvalue: newString as String)
            
            
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.TXTEmail {
            self.TXTEmail.resignFirstResponder()
            self.TXTPassword.becomeFirstResponder()
        }
        else {
            self.TXTEmail.becomeFirstResponder()
            self.TXTPassword.becomeFirstResponder()
        }
        return true
    }
}
