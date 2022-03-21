//
//  Extension.swift
//
//  Created by Hiren joshi on 21/10/19.
//  Copyright © 2019 Hiren Joshi. All rights reserved.
//

import UIKit
import Foundation

let ThemeSpace = "  "
/**
 String category class for make string functions easy to use
 */
extension String
{
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var isBlank:Bool {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    /**
     Convert argument string into localisedstring and display to caller controllers
     ### Usage Example: ###
     ````
     "locatized".localized()
     ````
     */
    func localized()->String
    {
//        return LanguageTool.sharedInstance.getStringForKey(self)//NSLocalizedString(self, tableName: "LiveLocalizable",  comment: "")
        return NSLocalizedString(self, comment: self)
    }
    
    func removeWhiteSpace() -> String {
        let trimmed = self.trimmingCharacters(in: .whitespaces)
        var final = trimmed.replacingOccurrences(of: ThemeSpace, with: "")
        final = final.replacingOccurrences(of: " ", with: "")
        return final.localized()
    }
    
    func customStringFormatting() -> String {
        return self.chunk(n: 1).map{ String($0) }.joined(separator: ThemeSpace).localized()
    }
    
    mutating func replaceLocalized(fromvalue: [String], tovalue: [String]) -> String {
        var replacestr: String = ""
        for (index, from) in fromvalue.enumerated() {
            replacestr = self.replacingOccurrences(of: from, with: tovalue[index])
            self = replacestr
        }
        return self.localized()
    }
    
    /**
     convert argument string into Date year format and display to caller controllers
     ### Usage Example: ###
     ````
     "string".currentYear()
     ````
     */
    static func currentYear()->String
    {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "YYYY"
        return myFormatter.string(from: Date())
    }
    
    /**
     convert argument string into Date Month format and display to caller controllers
     ### Usage Example: ###
     ````
     "string".currentMonth()
     ````
     */
    static func currentMonth()->String
    {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "MM"
        return myFormatter.string(from: Date())
    }
    
    /**
     Convert argument string into substring value
     - Parameters inputSTR: main string to get sub string.
     - Parameters substring: sub string to get form main string.
     - return array: return string array with stirng, int and int arguments
     
     ### Usage Example: ###
     ````
     String.FindSubString(inputStr: "main string", subStrings: ["sub string", "sub string"])
     ````
     */
    func FindSubString(inputStr : String, subStrings: Array<String>?) ->Array<(String, Int, Int)> {
        var resultArray : Array<(String, Int, Int)> = []
        for i: Int in 0...(subStrings?.count)!-1 {
            if inputStr.contains((subStrings?[i])!) {
                let range: Range<String.Index> = inputStr.range(of: subStrings![i])!
                let lPos = inputStr.distance(from: inputStr.startIndex, to: range.lowerBound)
                let uPos = inputStr.distance(from: inputStr.startIndex, to: range.upperBound)
                let element = ((subStrings?[i])! as String, lPos, uPos)
                resultArray.append(element)
            }
        }
        for words in resultArray {
            print("FindSubString: \(words)")
        }
        return resultArray
    }
    
    /**
     Convert argument string into range value
     - Parameters value: range value with (string, int, int)
     - return array: return given string range
     
     ### Usage Example: ###
     ````
     String.ConvertRange(value: ("string", 0, 10)))
     ````
     */
    func ConvertRange(value: (String, Int, Int)) -> NSRange {
        var range: NSRange!
        range = NSRange(location: value.1, length: value.2)
        return range
    }
    
    /**
     Convert argument string into attributestring
     - Parameters attribute: pass attrbute string array with (stirng, font, color)
     - Parameters mainstring: Main string with wont to convert into attribute string
     - Parameters rangearray: pass range range array
     - return array: return attribute string with given parameter consider.
     
     ### Usage Example: ###
     ````
     let string1: String = "".localized()
     let string2: String = "Enter The mobile no. Associated with your account \nWe will mobile no you link to reset your password.".localized() as String
     let mainstring: String = string1 + string2
     let myMutableString = mainstring.Attributestring(attribute: [(string1, Font().RegularFont(font: 15.0), UIColor.black), (string2, Font().RegularFont(font: 15.0), UIColor.lightGray)], with: mainstring, with: NSArray.init(array: mainstring.FindSubString(inputStr: mainstring, subStrings: [string1, string2])))
     self.Note_lbl.attributedText = myMutableString
     String.Attributestring(attribute: [(string, font, color)], mainstring: string, rangearray:[])
     ````
     */
    func Attributestring(attribute: Array<(String, UIFont, UIColor)>, with mainstring: String, with rangearray:NSArray) -> NSAttributedString {
        let myMutableString = NSMutableAttributedString.init()
        var index: Int = 0
        for obj in attribute {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: obj.1,
                .foregroundColor: obj.2,
            ]
            let rangestring: (String, Int, Int) = rangearray.object(at: index) as! (String, Int, Int)
            let attributestring = NSMutableAttributedString.init(string: rangestring.0, attributes: attributes)
            myMutableString.append(attributestring)
            index += 1
        }
        return myMutableString
    }
    
    /**
     Convert argument string into attributestring
     - Parameters attribute: pass attrbute string array with NSAttributedString.Key
     - Parameters mainstring: Main string with wont to convert into attribute string
     - Parameters rangearray: pass range range array
     - return array: return attribute string with given parameter consider.
     
     ### Usage Example: ###
     ````
     String.EditAttributestring(attribute: [NSAttributedStringKey], mainstring: string, rangearray:[])
     ````
     */
    func EditAttributestring(attribute: Array<([NSAttributedString.Key: Any])>, with mainstring: String, with rangearray:NSArray) -> NSAttributedString {
        let myMutableString = NSMutableAttributedString.init()
        var index: Int = 0
        for obj in attribute {
            let rangestring: (String, Int, Int) = rangearray.object(at: index) as! (String, Int, Int)
            let attributestring = NSMutableAttributedString.init(string: rangestring.0, attributes: obj)
            myMutableString.append(attributestring)
            index += 1
        }
        return myMutableString
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
}

/**
 Button category class for make button functions easy to use
 */
@objc extension UIButton
{
    /**
     Button maskround
     */
    func makeRound() {
        self.layer.cornerRadius = self.frame.height / 2.0
    }
    
    /**
     makefloating button
     */
    func makeFloating() {
        self.makeRound()
        //        self.layer.shadowColor = MainThemeColor.withAlphaComponent(0.3).cgColor
        //        self.layer.shadowRadius = 10
        //        self.layer.shadowOpacity = 1
    }
}

/**
 Label category class for make button functions easy to use
 */
@objc extension UILabel
{
    /**
     label maskround
     */
    func makeRound() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 5.0
    }
}

@objc extension UITableView {
    func lastIndexpath() -> IndexPath {
        let section = max(numberOfSections - 1, 0)
        let row = max(numberOfRows(inSection: section) - 1, 0)

        return IndexPath(row: row, section: section)
    }
}

@objc extension UIColor {
    static let primaryColor = UIColor(red:0.00, green:0.57, blue:0.98, alpha:1.0)
    
    // custom color methods
    class func colorWithHex(rgbValue: UInt32) -> UIColor {
        return UIColor( red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                        alpha: CGFloat(1.0))
    }
    
    class func colorWithHexString(hexStr: String) -> UIColor {
        var cString:String = hexStr.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (hexStr.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if (cString.isEmpty || (cString.count) != 6) {
            return colorWithHex(rgbValue: 0xFF5300);
        } else {
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            return colorWithHex(rgbValue: rgbValue);
        }
    }
    
    func changeImageColor(theImageView: UIImageView, newColor: UIColor) {
        theImageView.image = theImageView.image?.withRenderingMode(.alwaysOriginal)
        theImageView.tintColor = newColor;
    }
    
//    static var customAccent: UIColor {
//        if #available(iOS 13, *) {
//            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
//                if traitCollection.userInterfaceStyle == .dark {
//                    return MaterialUI.orange300
//                } else {
//                    return MaterialUI.orange600
//                }
//            }
//        } else {
//            return MaterialUI.orange600
//        }
//    }
    
}

@objc extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}

@objc extension UITextField {
    @objc func TextFieldCheckisDecimal(isdefault status: Bool, defaultvalue: String) {
        let Value = self.text
        var isNumeric: Bool {
            guard Value!.count > 0 else { return false }
            let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
            return Set(Value!).isSubset(of: nums)
        }
        var isDecimal: Bool {
            guard Value!.count > 0 else { return false }
            let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."]
            return Set(Value!).isSubset(of: nums)
        }
        if isNumeric {
            if Value == "0" || Value == "00" {
                if status {
                    self.text = String.init(format: "%@", Int(defaultvalue)!)
                }
                else {
                    self.text = ""
                }
            }
            else {
                if Value!.hasPrefix("0") || Value!.hasPrefix("00") {
                    //                    let numberAsInt = Int(Value)
                    let str = Value!.replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
                    self.text = str.count == 0 ? String.init(format: "%@", Int(defaultvalue)!) : str
                }
                else {
                    if status {
                        self.text = String.init(format: "%@", Int(defaultvalue)!)
                    }
                    else {
                        self.text = Value
                    }
                }
            }
        }
        else if isDecimal {
            if Value == "0.0" {
                self.text = ""
            }
            else {
                self.text = Value
            }
        }
        else {
            self.text = Value
        }
    }
    
    func IsContainCharacter(textvalue: String) -> Bool {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        if textvalue.rangeOfCharacter(from: characterset) != nil {
            return true
        }
        return false
    }
    
    func IsContainUppercase(textvalue: String) -> Bool {
        let characterset = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        if textvalue.rangeOfCharacter(from: characterset) != nil {
            return true
        }
        return false
    }
    
    func IsContainDigit(textvalue: String) -> Bool {
        let characterset = CharacterSet(charactersIn: "0123456789")
        if textvalue.rangeOfCharacter(from: characterset) != nil {
            return true
        }
        return false
    }
    
    func IsContainSpecialCharacter(textvalue: String) -> Bool {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        if textvalue.rangeOfCharacter(from: characterset.inverted) != nil {
            return true
        }
        return false
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
     
        // at least one uppercase,
        // at least one digit
        // at least one special character
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
}

extension Collection {
    public func chunk(n: IndexDistance) -> [SubSequence] {
        var res: [SubSequence] = []
        var i = startIndex
        var j: Index
        while i != endIndex {
            j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
            res.append(self[i..<j])
            i = j
        }
        return res
    }
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}

extension UIView{
    func animShow(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
}
