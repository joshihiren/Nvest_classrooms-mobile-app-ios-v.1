//
//  View.swift
//  NTI
//
//  Created by Vetron Service on 14/12/18.
//  Copyright © 2018 Vetron services. All rights reserved.
//

import UIKit

@IBDesignable class CustomView: UIView {

    @IBInspectable var BGColor: UIColor = UIColor.white {
        didSet{
            self.backgroundColor = self.BGColor
        }
    }
    @IBInspectable var isCircle: Bool = false {
        didSet{
            if isCircle {
                layer.cornerRadius = self.frame.size.height / 2
            }
        }
    }
    @IBInspectable var BorderColor: UIColor = UIColor.clear {
        didSet{
            layer.borderColor = BorderColor.cgColor
        }
    }
    @IBInspectable var ShadowColor: UIColor = UIColor.black {
        didSet{
            layer.shadowColor = ShadowColor.cgColor
        }
    }
    @IBInspectable var BorderWidth: CGFloat = 0 {
        didSet{
            layer.borderWidth = BorderWidth
        }
    }
    @IBInspectable var CornerRadius: CGFloat = 0 {
        didSet{
            layer.cornerRadius = CornerRadius
        }
    }
    @IBInspectable var ShadowRadius: CGFloat = 0 {
        didSet{
            layer.shadowRadius = ShadowRadius
        }
    }
    @IBInspectable var ShadowOpacity: CGFloat = 0 {
        didSet{
            layer.shadowOpacity = Float(ShadowOpacity)
        }
    }
    @IBInspectable var ShadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet{
            layer.shadowOffset = ShadowOffset
        }
    }
    @IBInspectable var maskBound: Bool = false {
        didSet{
            layer.masksToBounds = maskBound
        }
    }
    @IBInspectable var clickBound: Bool = true {
        didSet{
            clipsToBounds = clickBound
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

extension UIView {
    func ViewroundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
