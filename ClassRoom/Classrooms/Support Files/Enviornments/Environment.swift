//
//  Environment.swift
//
//  Created by Shorupan Pirakaspathy on 2020-03-27.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

public enum PlistKey {
    case TimeoutInterval
    case ConnectionProtocol
    case ServerURL
    case DomainFolder
    case LoginApi
    case ForgotpasswordRequestAPI
    case ForgotpasswordConfirmAPI
    case SignupApi
    case ChangePasswordAPI
    case AllClassroomAPI
    case SelectedCategoryClassAPI
    case CategoryDetailDesignAPI
    case CategoryClassesAPI
    case SearchClassroomAPI
    
    
    func value() -> String {
        switch self {
        case .TimeoutInterval:
            return "timeout_interval"
        case .ConnectionProtocol:
            return "protocol"
        case .ServerURL:
            return "server_url"
        case .DomainFolder:
            return "DomainFolder"
        case .LoginApi:
            return "LoginApi"
        case .ForgotpasswordRequestAPI:
            return "ForgotpasswordRequestAPI"
        case .ForgotpasswordConfirmAPI:
            return "ForgotpasswordConfirmAPI"
        case .SignupApi:
            return "SignupApi"
        case .ChangePasswordAPI:
            return "ChangePasswordAPI"
        case .AllClassroomAPI:
            return "AllClassroomAPI"
        case .SelectedCategoryClassAPI:
            return "SelectedCategoryClassAPI"
        case .CategoryDetailDesignAPI:
            return "CategoryDetailDesignAPI"
        case .CategoryClassesAPI:
            return "CategoryClassesAPI"
        case .SearchClassroomAPI:
            return "SearchClassroomAPI"
        }
    }
}

public struct Environments {
    
    static let shared = Environments()
    
    fileprivate var infoDict1: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }else {
                fatalError("Plist file not found")
            }
        }
    }
    
    var infoDict: [String : Any]!
    
    private init() {
        if let dict = Bundle.main.infoDictionary {
            self.infoDict = dict
        }else {
            fatalError("Plist file not found")
        }
    }
    
    public func configuration(_ key: PlistKey) -> String {
        let keyExists = infoDict[key.value()] != nil
        if keyExists {
            print("The key is present in the Infodictionary")
            switch key {
            case .TimeoutInterval:
                return infoDict[PlistKey.TimeoutInterval.value()] as! String
            case .ConnectionProtocol:
                return infoDict[PlistKey.ConnectionProtocol.value()] as! String
            case .ServerURL:
                return infoDict[PlistKey.ServerURL.value()] as! String
            case .DomainFolder:
                return infoDict[PlistKey.DomainFolder.value()] as! String
            case .LoginApi:
                return infoDict[PlistKey.LoginApi.value()] as! String
            case .ForgotpasswordRequestAPI:
                return infoDict[PlistKey.ForgotpasswordRequestAPI.value()] as! String
            case .ForgotpasswordConfirmAPI:
                return infoDict[PlistKey.ForgotpasswordConfirmAPI.value()] as! String
            case .SignupApi:
                return infoDict[PlistKey.SignupApi.value()] as! String
            case .ChangePasswordAPI:
                return infoDict[PlistKey.ChangePasswordAPI.value()] as! String
            case .AllClassroomAPI:
                return infoDict[PlistKey.AllClassroomAPI.value()] as! String
            case .SelectedCategoryClassAPI:
                return infoDict[PlistKey.SelectedCategoryClassAPI.value()] as! String
            case .CategoryDetailDesignAPI:
                return infoDict[PlistKey.CategoryDetailDesignAPI.value()] as! String
            case .CategoryClassesAPI:
                return infoDict[PlistKey.CategoryClassesAPI.value()] as! String
            case .SearchClassroomAPI:
                return infoDict[PlistKey.SearchClassroomAPI.value()] as! String
            }
        } else {
            print("The key is not present in the Infodictionary")
            return ""
        }
    }
    
    public func GetDomainURL(_ key: PlistKey) -> String {
        let protocols = Environments.shared.configuration(PlistKey.ConnectionProtocol)
        let serverurl = Environments.shared.configuration(PlistKey.ServerURL)
        let domainfolder = Environments.shared.configuration(PlistKey.DomainFolder)
        let callKey = Environments.shared.configuration(key)
        if protocols.count != 0 || serverurl.count != 0 || callKey.count != 0 {
            let APIURL = String.init(format: "%@://%@%@%@", protocols, serverurl, domainfolder, callKey)
            return callKey.count >= 1 ? APIURL : ""
        }
        else {
            return ""
        }
    }
    
    public func getPlistFilename() -> String {
        #if Dev_DEBUG || Dev_RELEASE
        return "Dev"
        #elseif UAT_DEBUG || UAT_RELEASE
        return "UAT"
        #elseif QA_DEBUG || QA_RELEASE
        return "QA"
        #else
        return "Prod"
        #endif
    }
    
    public func getPath() -> String {
        let plistFileName: String!
        plistFileName = self.getPlistFilename()
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentPath = paths[0] as NSString
        let plistPath = documentPath.appendingPathComponent(plistFileName)
        return plistPath
    }
    
    public func RetrivePlistdata()-> NSDictionary? {
        if FileManager.default.fileExists(atPath: self.getPath()) {
            let dict = NSMutableDictionary.init(contentsOfFile: self.getPath())
            return dict
        }
        return nil
    }
    
    public func RemovePlistdata(key: String) {
        if FileManager.default.fileExists(atPath: self.getPath()) {
            let dict: NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: self.getPath())!
            dict.removeObject(forKey: key)
            dict.write(toFile: self.getPath(), atomically: true)
        }
    }
    
    public func updatePlistdata(key: String, value: Any) {
        if FileManager.default.fileExists(atPath: self.getPath()) {
            let dict: NSMutableDictionary = NSMutableDictionary.init(contentsOfFile: self.getPath())!
            let data = dict.object(forKey: key) as AnyObject
            if data.isMember(of: NSArray.self) {
                dict.setValue(value, forKey: key)
            }
            else if data.isMember(of: NSDictionary.self) {
                dict.setValue(value, forKey: key)
            }
            else {
                dict.setValue(data, forKey: key)
            }
            dict.write(toFile: self.getPath(), atomically: true)
        }
    }
    
}
