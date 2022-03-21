//
//  AppMacros.swift
//  ClassRoom
//
//  Created by Shorupan Pirakaspathy on 2020-03-27.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit
import Foundation

let AppDarkHex                          = "186AB4"
let AppDarkColor                        = UIColor(red:0.09, green:0.42, blue:0.71, alpha:1)

let REGEX_USER_NAME_LIMIT               = "^.{3,10}$"
let REGEX_USER_NAME                     = "[A-Za-z0-9]{3,10}"
let REGEX_TITLE_LIMIT                   = "^.{3,20}$"
let REGEX_TITLE                         = "[A-Za-z0-9]{3,20}"
let REGEX_DATE                          = "[0-9]{1,2}+[/]{1,1}+[0-9]{2,4}"
let REGEX_TIME                          = "[0-9]{1,2}+[:]{1,1}+[0-9]{1,2}"
let REGEX_LOCATION                      = "[A-Za-z0-9,-_ ]{1,50}"
let REGEX_EMAIL                         = "[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
let REGEX_PASSWORD_LIMIT                = "^.{6,20}$"
let REGEX_PASSWORD                      = "[A-Za-z0-9]{6,20}"
let REGEX_PHONE_DEFAULT                 = "[0-9]{10,12}"

let ShortVersion                        = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
let DisplayName                         = Bundle.main.infoDictionary?["CFBundleName"] as! String
let BuildName                           = Bundle.main.infoDictionary?["CFBundleVersion"] as! String

// MARK: - -------------------- UIResponder --------------------
// MARK: -

let Screen_width                        = UIScreen.main.bounds.size.width
let Screen_height                       = UIScreen.main.bounds.size.height
let Language                            = NSLocale.preferredLanguages.first
let isIphoneXR                          = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 828, height: 1792)) ?? false
let isIphoneXSMAX                       = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1242, height: 2688)) ?? false
let isXseries                           = isIphoneX || isIphoneXR || isIphoneXSMAX

let TopNavHeight : CGFloat              = isXseries ? 84 : 64
let TabbarHeight : CGFloat              = isXseries ? 83 : 49
let StateBarHeight : CGFloat            = isXseries ? 44 : 20
let NavBarHeight : CGFloat              = isXseries ? 64 : 44
let BottomSafeAreaHeight : CGFloat      = isXseries ? 34 : 0
let TopSafeAreaHeight : CGFloat         = isXseries ? 24 : 0
let UnderSafeArea : CGFloat             = isXseries ? 24 : 20

let isIphone5 : Bool                    = (UIScreen.main.bounds.height == 568) //se
let isIphone6 : Bool                    = (UIScreen.main.bounds.height == 667) //6/6s/7/7s/8
let isIphone6P : Bool                   = (UIScreen.main.bounds.height == 736) //6p/6sp/7p/7sp/8p
let isIphoneX : Bool                    = Int((Screen_height / Screen_width) * 100) == 216 ? true : false

let App                                 = UIApplication.shared.delegate as? AppDelegate
public let UserDefault                  = UserDefaults.standard

// MARK: - -------------------- Storyboard --------------------
// MARK: -

func getStroyboard(_ StoryboardWithName: Any) -> UIStoryboard {
    return UIStoryboard(name: StoryboardWithName as! String, bundle: nil)
}
func loadViewController(_ StoryBoardName: Any, _ VCIdentifier: Any) -> UIViewController {
    return getStroyboard(StoryBoardName).instantiateViewController(withIdentifier: VCIdentifier as! String)
}

