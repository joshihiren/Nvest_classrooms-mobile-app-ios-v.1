//
//  UserInfoData.swift
//  ClassRoom
//
//  Created by Shorupan Pirakaspathy on 2020-03-31.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit

let LoginKey = "UserInfo"

@objc public class UserInfoData: NSObject {

    static let shared = UserInfoData()
    public var mydefault : UserDefaults!
    
    @objc class var swiftSharedInstance: UserInfoData {
        struct Singleton {
            static let instance = UserInfoData()
        }
        return Singleton.instance
    }
    
    // the sharedInstance class method can be reached from ObjC
    @objc class func sharedInstance() -> UserInfoData {
        return UserInfoData.swiftSharedInstance
    }
    
    private override init() {
        self.mydefault = UserDefaults.standard
        self.mydefault.synchronize()
    }
    
    func SaveUserInfodata(info: UserinfoRootClass) {
        let personData = NSKeyedArchiver.archivedData(withRootObject: info)
        self.mydefault.set(personData, forKey: LoginKey)
    }
    
    func GetUserInfodata() -> UserinfoRootClass? {
        let personData = self.mydefault.object(forKey: LoginKey) as! NSData?
        if personData == nil {
            return nil
        }
        else {
            let info = NSKeyedUnarchiver.unarchiveObject(with: personData! as Data) as! UserinfoRootClass
            return info
        }
    }
    
    @objc func UserLogout() {
        let domain = Bundle.main.bundleIdentifier!
        self.mydefault.removePersistentDomain(forName: domain)
        self.mydefault.synchronize()
        print(Array(self.mydefault.dictionaryRepresentation().keys).count)
        App?.SetLoginVC()
    }
    
}
