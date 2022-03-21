//
//  Font.swift
//
//  Created by Hiren Joshi on 05/08/19.
//  Copyright © 2019 Hiren Joshi. All rights reserved.
//

import UIKit
import Foundation

/**
 Font category classes
 */
class Font: UIFont {
    /**
     Get LightFont
     - Parameter size: pass cgfloat font size for set font size
     - Return Font: Will return with font family with Poppins-Light and font size will be given size
     
     ### Usage Example: ###
     ````
     Font().LightFont(size:20.0)
     ````
     */
    func LightFont(font size: CGFloat) -> UIFont {
        let font = UIFont(name: "Helvetica Neue", size: size)
        return font!
    }
    
    /**
     Get MediumFont
     - Parameter size: pass cgfloat font size for set font size
     - Return Font: Will return with font family with Poppins-Medium and font size will be given size
     
     ### Usage Example: ###
     ````
     Font().MediumFont(size:20.0)
     ````
     */
    func MediumFont(font size: CGFloat) -> UIFont {
        let font = UIFont(name: "Helvetica Neue", size: size)
        return font!
    }
    
    /**
     Get RegularFont
     - Parameter size: pass cgfloat font size for set font size
     - Return Font: Will return with font family with Poppins-Light and font size will be given size
     
     ### Usage Example: ###
     ````
     Font().RegularFont(size:20.0)
     ````
     */
    func RegularFont(font size: CGFloat) -> UIFont {
        let font = UIFont(name: "Helvetica Neue", size: size)
        return font!
    }
    
    /**
     Get BoldFont
     - Parameter size: pass cgfloat font size for set font size
     - Return Font: Will return with font family with Poppins-Bold and font size will be given size
     
     ### Usage Example: ###
     ````
     Font().BoldFont(size:20.0)
     ````
     */
    func BoldFont(font size: CGFloat) -> UIFont {
        let font = UIFont(name: "Helvetica Neue", size: size)
        return font!
    }
    
    /**
     Get SemiBoldFont
     - Parameter size: pass cgfloat font size for set font size
     - Return Font: Will return with font family with Poppins-SemoBold and font size will be given size
     
     ### Usage Example: ###
     ````
     Font().SemiBoldFont(size:20.0)
     ````
     */
    func SemiBoldFont(font size: CGFloat) -> UIFont {
        let font = UIFont(name: "Helvetica Neue", size: size)
        return font!
    }
    
    /**
     Get RealRegularFont
     - Parameter size: pass cgfloat font size for set font size
     - Return Font: Will return with font family with Poppins-Regular and font size will be given size
     
     ### Usage Example: ###
     ````
     Font().RealRegularFont(size:20.0)
     ````
     */
    func RealRegularFont(font size: CGFloat) -> UIFont {
        let font = UIFont(name: "Helvetica Neue", size: size)
        return font!
    }
}
