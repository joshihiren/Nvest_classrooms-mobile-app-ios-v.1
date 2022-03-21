//
//  CustomBTN.swift
//  NTI
//
//  Created by Vetron Service on 14/12/18.
//  Copyright © 2018 Vetron services. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomBTN: UIButton {
    @IBInspectable var BTN_BGColor: UIColor = UIColor.white {
        didSet{
            self.backgroundColor = BTN_BGColor
        }
    }
    @IBInspectable var BTN_isCircle: Bool = false {
        didSet{
            if BTN_isCircle {
                layer.cornerRadius = self.frame.size.height / 2
            }
        }
    }
    @IBInspectable var BTN_BorderWidth: CGFloat = 0 {
        didSet{
            layer.borderWidth = BTN_BorderWidth
        }
    }
    @IBInspectable var BTN_CornerRadius: CGFloat = 0 {
        didSet{
            if !BTN_isCircle {
                layer.cornerRadius = BTN_CornerRadius
            }
        }
    }
    @IBInspectable var BTN_BorderColor: UIColor = UIColor.clear {
        didSet{
            layer.borderColor = BTN_BorderColor.cgColor
        }
    }

    @IBInspectable var BTN_ShadowColor: UIColor = UIColor.black {
        didSet{
            layer.shadowColor = BTN_ShadowColor.cgColor
        }
    }
    @IBInspectable var BTN_ShadowRadius: CGFloat = 0 {
        didSet{
            layer.shadowRadius = BTN_ShadowRadius
        }
    }
    @IBInspectable var BTN_ShadowOpacity: CGFloat = 0 {
        didSet{
            layer.shadowOpacity = Float(BTN_ShadowOpacity)
        }
    }
    @IBInspectable var BTN_ShadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet{
            layer.shadowOffset = BTN_ShadowOffset
        }
    }
    @IBInspectable var BTN_MaskToBound: Bool = false {
        didSet{
            layer.masksToBounds = BTN_MaskToBound
        }
    }
    @IBInspectable var BTN_clipBound: Bool = false {
        didSet{
            self.clipsToBounds = BTN_clipBound
        }
    }
    @IBInspectable var BTN_Image: UIImage = CustomBTN.getDefaultImage() {
        didSet{
            self .setImage(BTN_Image, for: .normal)
            self.backgroundColor = UIColor.groupTableViewBackground
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

    }

    class func getDefaultImage()-> UIImage {
        if let defaultImage = UIImage(named: "") {
            return defaultImage
        } else {
            return UIImage()
        }
    }
}

extension UIButton {
    func BTNroundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
