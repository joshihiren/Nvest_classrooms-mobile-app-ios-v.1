//
//  CustomLbl.swift
//  NTI
//
//  Created by Vetron Service on 14/12/18.
//  Copyright © 2018 Vetron services. All rights reserved.
//

import UIKit

@IBDesignable class CustomLBL: UILabel {

    @IBInspectable var LBL_BGColor: UIColor = UIColor.white {
        didSet{
            self.backgroundColor = LBL_BGColor
        }
    }
    @IBInspectable var LBL_isCircle: Bool = false {
        didSet{
            if LBL_isCircle {
                layer.cornerRadius = self.frame.size.height / 2
            }
        }
    }
    @IBInspectable var LBL_BorderWidth: CGFloat = 0 {
        didSet{
            layer.borderWidth = LBL_BorderWidth
        }
    }
    @IBInspectable var LBL_CornerRadius: CGFloat = 0 {
        didSet{
            if !LBL_isCircle {
                layer.cornerRadius = LBL_CornerRadius
            }
        }
    }
    @IBInspectable var LBL_BorderColor: UIColor = UIColor.clear {
        didSet{
            layer.borderColor = LBL_BorderColor.cgColor
        }
    }

    @IBInspectable var LBL_ShadowColor: UIColor = UIColor.black {
        didSet{
            layer.shadowColor = LBL_ShadowColor.cgColor
        }
    }
    @IBInspectable var LBL_ShadowRadius: CGFloat = 0 {
        didSet{
            layer.shadowRadius = LBL_ShadowRadius
        }
    }
    @IBInspectable var LBL_ShadowOpacity: CGFloat = 0 {
        didSet{
            layer.shadowOpacity = Float(LBL_ShadowOpacity)
        }
    }
    @IBInspectable var LBL_ShadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet{
            layer.shadowOffset = LBL_ShadowOffset
        }
    }
    @IBInspectable var LBL_MaskToBound: Bool = false {
        didSet{
            layer.masksToBounds = LBL_MaskToBound
        }
    }
    @IBInspectable var LBL_clipBound: Bool = false {
        didSet{
            self.clipsToBounds = LBL_clipBound
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
}

extension UILabel {
    func LBLroundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
