//
//  UserUtility.swift
//
//  Created by Hiren Joshi on 12/08/19.
//  Copyright © 2019 Hiren Joshi. All rights reserved.
//

import UIKit
import ContactsUI
/**
 User Utility class for some comman functionality
 
 ### Usage Example: ###
 ````
 UserUtility.
 ````
 */
@objc public class UserUtility: NSObject {
    
    
    @objc class func ViewBgColor() -> UIColor {
        return UIColor(red:0.95, green:0.95, blue:0.97, alpha:1.0)
    }
    
    @objc class func ViewBgColorHex() -> String {
        return "#f2f2f7"
    }
    
    /**
     Get Random string as per len pass.
     - Parameters len: Pass length with int type.
     - Return: That will return with string with length of pass int value by user.
     
     ### Usage Example: ###
     ````
     UserUtility.randomString(len: 30)
     ````
     */
    @objc class func randomString(len:Int) -> String {
        let charSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let c = Array(charSet)
        var s:String = ""
        for _ in (0...len) {
            s.append(c[Int(arc4random()) % c.count])
        }
        return s
    }
    
    /**
     Get Userpushnotification Device token which register to pushnotification cetificate
     - Return: That will return devices token which is store in userdefault with key "DeviecToken"
     - Return: If user had not store the device token in userdefault and get nil devices token thatn it will automatically return random 30 charactor string
     
     - Notes: With store devicetoken into user default
     ### Success Usage Example: ###
     ````
     UserUtility.getDevicetoken()
     ````
     - Notes: With does not store devicetoken into user default
     ### Fail Usage Example: ###
     ````
     UserUtility.randomString(len: 30)
     ````
     */
    @objc class func getDevicetoken() -> String {
        let device_token = ""
        if device_token.count == 0 {
            return device_token
        }
        else{
            return self.randomString(len: 30)
        }
    }
    
    /**
    Read File from document directory
    
    - Description: Call methods, that will automatically read give file with extension and return [String : Any] format
    
    ### Usage Example: ###
    ````
    UserUtility.ReadFile(filename: "", filetype: "")
    ````
    */
    @objc class func ReadFile(filename name: String, filetype type: String) -> [String : Any] {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let responseObject = jsonResult as? [String : Any] {
                    return responseObject
                }
                else {
                    return [:]
                }
            } catch {
                return [:]
            }
        }
        return [:]
    }
    
    @objc class func isCustomApiDomain(domain: String) -> Bool {
        let domains = UserDefaults.standard.object(forKey: "HOST_NAME") as! String
        if domains.uppercased() == domain.uppercased() {
            return true
        }
        else {
            return false
        }
    }
    
    @objc class func isObjectNotNil(object:AnyObject!) -> Bool
    {
        if let _:AnyObject = object
        {
            return true
        }
        return false
    }
    
    @objc class func getOnlyDate(FullDate:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss a"
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let tmpDate = dateFormatter.date(from: FullDate)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let tmpStrDate = dateFormatter.string(from: tmpDate!)
        return tmpStrDate
    }
    
    @objc class func GetDatewithFormat(Formate: String) ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Formate
        let tmpDate = dateFormatter.string(from: Date())
        return tmpDate
    }
    
    @objc class func GetTomorrowDatewithFormat(Formate: String) ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Formate
        let tmpDate = dateFormatter.string(from: Date.tomorrow)
        return tmpDate
    }
    
    @objc class func GetYesterdayDatewithFormat(Formate: String) ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Formate
        let tmpDate = dateFormatter.string(from: Date.yesterday)
        return tmpDate
    }
    
    @objc class func IsStringNilOrCount(value: Any?) -> Bool {
            
        guard let myString: String = value as? String, !myString.isEmpty else {
            print("String is nil or empty.")
            return true
        }
        if myString == nil && myString.count == 0 && myString.isEmpty {
            guard myString.isEmpty else {
                print("String is nil or empty.")
                return true
            }
            guard myString == nil else {
                return true
            }
            return false
        }
        guard myString.isBlank else {
            return false
        }
        return true
    }
    
    @objc class func getAppColor() -> UIColor {
        if #available(iOS 11.0, *) {
            return UIColor.init(named: "ThemeColor")!
        } else {
            return UIColor.white
        }
    }
    
    @objc class func getRootViewcontroller() -> UIViewController {
        return UIApplication.shared.windows.first!.rootViewController!
    }
    
    @objc class func removeSpecialCharsFromString(text: String) -> String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+")
        return text.filter {okayChars.contains($0) }
    }
    
    @objc class func GetContactdetailsFromCNContact(contact: CNContact, ContactData: ((_ Name: String, _ number: String)->Void)?) {
        let contactName = (contact.givenName + " " + contact.middleName + " " + contact.familyName) as NSString
        var contactNumber = "" as NSString
        
        if contact.phoneNumbers.count > 0
        {
            let label = contact.phoneNumbers.first! as CNLabeledValue
            contactNumber = UserUtility.removeSpecialCharsFromString(text: label.value.stringValue) as NSString
        }
        ContactData!(contactName as String, contactNumber as String)
    }
    
    @objc class func getContactFromCNContact() -> [CNContact] {

        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactGivenNameKey,
            CNContactMiddleNameKey,
            CNContactFamilyNameKey,
            CNContactEmailAddressesKey,
            CNContactOrganizationNameKey,
            CNContactPhoneNumbersKey
            ] as [Any]

        //Get all the containers
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }

        var results: [CNContact] = []

        // Iterate all containers and append their contacts to our results array
        for container in allContainers {

            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)

            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)

            } catch {
                print("Error fetching results for container")
            }
        }
    
        return results
    }

    @objc class func SearchContactfromDevices(contactID: String) -> [CNContact] {
        let predicate = CNContact.predicateForContacts(withIdentifiers: [contactID])
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactGivenNameKey, CNContactMiddleNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactOrganizationNameKey] as [Any]
        var contacts = [CNContact]()
        var message: String!
        let contactStore = CNContactStore()
        do {
            contacts = try contactStore.unifiedContacts(matching: predicate, keysToFetch: keys as! [CNKeyDescriptor])
            if contacts.count == 0 {
                message = "No contacts were found matching the given name."
            }
        }
        catch {
            message = "Unable to fetch contacts."
        }
        if message != nil {
            print("self.contact: \(String(describing: message))")
        } else {
            print("self.contact: \(contacts)")
        }
        return contacts
    }
    
    @objc class func GetTimeMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
    
        switch hour {
        case 6..<12 : return "Good Morning".localized()
        case 12 : return "Good Noon".localized()
        case 13..<17 : return "Good Afternoon".localized()
        case 17..<22 : return "Good Evening".localized()
        default: return "Good Night".localized()
        }
    }
}

