//
//    UserinfoRootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class UserinfoRootClass : NSObject, NSCoding{

    var accessToken : String!
    var deviceKey : String!
    var idToken : String!
    var message : String!
    var refreshToken : String!
    var status : Bool!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        accessToken = dictionary["accessToken"] as? String
        deviceKey = dictionary["device_key"] as? String
        idToken = dictionary["idToken"] as? String
        message = dictionary["message"] as? String
        refreshToken = dictionary["refreshToken"] as? String
        status = dictionary["status"] as? Bool
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accessToken != nil{
            dictionary["accessToken"] = accessToken
        }
        if deviceKey != nil{
            dictionary["device_key"] = deviceKey
        }
        if idToken != nil{
            dictionary["idToken"] = idToken
        }
        if message != nil{
            dictionary["message"] = message
        }
        if refreshToken != nil{
            dictionary["refreshToken"] = refreshToken
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
         deviceKey = aDecoder.decodeObject(forKey: "device_key") as? String
         idToken = aDecoder.decodeObject(forKey: "idToken") as? String
         message = aDecoder.decodeObject(forKey: "message") as? String
         refreshToken = aDecoder.decodeObject(forKey: "refreshToken") as? String
         status = aDecoder.decodeObject(forKey: "status") as? Bool

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if accessToken != nil{
            aCoder.encode(accessToken, forKey: "accessToken")
        }
        if deviceKey != nil{
            aCoder.encode(deviceKey, forKey: "device_key")
        }
        if idToken != nil{
            aCoder.encode(idToken, forKey: "idToken")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if refreshToken != nil{
            aCoder.encode(refreshToken, forKey: "refreshToken")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }

    }

}
