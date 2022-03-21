//
//  ParamStruct.swift
//  Lead
//
//  Created by Hiren Joshi on 22/01/20.
//  Copyright © 2020 Hiren Joshi. All rights reserved.
//

import Foundation

struct CommanParamDict: Encodable {
    var personid : String
    var companyId : String
    
    init() {
        self.personid = ""
        self.companyId = ""
    }
    
    var description: [String:Any] {
        get {
            return ["personid": self.personid, "companyid": self.companyId] as [String:Any]
        }
    }
    
}

struct MasterClientParamDict: Encodable {
    var searchtxt : String
//    var Coman: [CommanParamDict]
    
    var description:[String:Any] {
        get {
            let Coman = CommanParamDict.init()
            return ["searchtext":searchtxt, "personid": Coman.personid as Any, "companyid": Coman.companyId as Any] as [String : Any]
//            return ["searchtext":searchtxt, "personid": self.Coman.first?.personid as Any, "companyid": self.Coman.first?.companyId as Any] as [String : Any]
        }
    }
}


struct LoginParamDict: Encodable {
    var ids: String
    var password: String
    
    var description: [String : Any] {
        get {
            return ["email" : ids.removeWhiteSpace(), "password": password.removeWhiteSpace()]
        }
    }
}

struct ForgotRequestParamDict: Encodable {
    var email: String
    
    var description: [String : Any] {
        get {
            return ["email" : email.removeWhiteSpace()]
        }
    }
}

struct ForgotPassConfirmParamDict: Encodable {
    var email: String
    var code: String
    var pass: String
    
    var description: [String : Any] {
        get {
            return ["email" : email.removeWhiteSpace(), "code": code.removeWhiteSpace(), "newPassword": pass.removeWhiteSpace()]
        }
    }
}

struct SignupParamDict: Encodable {
    var username: String
    var email: String
    var password: String
    var ref_affiliate: String
    var account_type: String
    var signedup_app: String
    
    var description: [String : Any] {
        get {
            return ["username": username.removeWhiteSpace(),
            "email": email.removeWhiteSpace(),
            "password": password.removeWhiteSpace(),
            "ref_affiliate": ref_affiliate.count == 0 ? "1" : ref_affiliate,
            "account_type": account_type.count == 0 ? "Personal" : account_type,
            "signedup_app": signedup_app.count == 0 ? "GX" : signedup_app]
        }
    }
}

struct ChangepasswordParamDict: Encodable {
    var email: String
    var currentPassword: String
    var newPassword: String
    var accessToken: String
    
    var description: [String : Any] {
        get {
            return ["email": email.removeWhiteSpace(),
            "currentPassword": currentPassword.removeWhiteSpace(),
            "newPassword": newPassword.removeWhiteSpace(),
            "accessToken": accessToken]
        }
    }
}

struct SearchCatParamDict: Encodable {
    var SearchSTR: String
    var dropType: String

    var description: [String: Any] {
        get {
            return ["Search": SearchSTR, "dropType": dropType]
        }
    }
}

struct AllCalssParamDict: Encodable {
    var SearchSTR: String

    var description: [String: Any] {
        get {
            return ["Search": SearchSTR]
        }
    }
}

struct SelectedCalssParamDict: Encodable {
    var SearchSTR: String

    var description: [String: Any] {
        get {
            return ["Search": SearchSTR]
        }
    }
}

struct DesignCalssParamDict: Encodable {
    var SearchSTR: String

    var description: [String: Any] {
        get {
            return ["Search": SearchSTR]
        }
    }
}

struct TutorialParamDict: Encodable {
    var SearchSTR: String

    var description: [String: Any] {
        get {
            return ["Search": SearchSTR]
        }
    }
}
