//
//  CustomIMG.swift
//  NTI
//
//  Created by Vetron Service on 14/12/18.
//  Copyright © 2018 Vetron services. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomIMG: UIImageView {

    @IBInspectable var IMG_BGColor: UIColor = UIColor.white {
        didSet{
            self.backgroundColor = IMG_BGColor
        }
    }
    @IBInspectable var IMG_isCircle: Bool = false {
        didSet{
            if IMG_isCircle {
                layer.cornerRadius = self.frame.size.height / 2
            }
        }
    }
    @IBInspectable var IMG_BorderWidth: CGFloat = 0 {
        didSet{
            layer.borderWidth = IMG_BorderWidth
        }
    }
    @IBInspectable var IMG_CornerRadius: CGFloat = 0 {
        didSet{
            if !IMG_isCircle {
                layer.cornerRadius = IMG_CornerRadius
            }
        }
    }
    @IBInspectable var IMG_BorderColor: UIColor = UIColor.clear {
        didSet{
            layer.borderColor = IMG_BorderColor.cgColor
        }
    }
    
    @IBInspectable var IMG_ShadowColor: UIColor = UIColor.black {
        didSet{
            layer.shadowColor = IMG_ShadowColor.cgColor
        }
    }
    @IBInspectable var IMG_ShadowRadius: CGFloat = 0 {
        didSet{
            layer.shadowRadius = IMG_ShadowRadius
        }
    }
    @IBInspectable var IMG_ShadowOpacity: CGFloat = 0 {
        didSet{
            layer.shadowOpacity = Float(IMG_ShadowOpacity)
        }
    }
    @IBInspectable var IMG_ShadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet{
            layer.shadowOffset = IMG_ShadowOffset
        }
    }
    @IBInspectable var IMG_MaskToBound: Bool = false {
        didSet{
            layer.masksToBounds = IMG_MaskToBound
        }
    }
    @IBInspectable var IMG_clipBound: Bool = false {
        didSet{
            self.clipsToBounds = IMG_clipBound
        }
    }

    //    MARK:- Initial Methods
    //    MARK:-

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func prepareForInterfaceBuilder() {
        initialSetup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        initialSetup()
    }

//    MARK:- Custom Methods
//    MARK:-

    func initialSetup() {
//        let myInsets : UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//        self.image = self.image?.resizableImage(withCapInsets: myInsets)
    }

    class func getDefaultImage()-> UIImage {
        if let defaultImage = UIImage(named: "") {
            return defaultImage
        } else {
            return UIImage()
        }
    }
}

extension UIImageView {
    func IMGroundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
