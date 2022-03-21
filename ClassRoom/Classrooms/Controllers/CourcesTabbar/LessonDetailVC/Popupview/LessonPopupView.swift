//
//  LessonPopupView.swift
//  Classrooms
//
//  Created by Shorupan Pirakaspathy on 2020-04-17.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit

class LessonPopupView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var LessonList: UICollectionView!
    @IBOutlet weak var HidePopup: UIButton!
    
    func HideactionHandler(action:(() -> Void)? = nil) {
        struct __ { static var action :(() -> Void)? }
        if action != nil { __.action = action }
        else { __.action?() }
    }
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("LessonPopupView", owner: self, options: nil)
//        view.frame = self.bounds
        self.backgroundColor = .clear
        self.view.backgroundColor = .white
        let maskPath = UIBezierPath(roundedRect: CGRect.init(x: 0, y: 0, width: Screen_width, height: self.view.frame.height),
                                    byRoundingCorners: [.bottomLeft],
                                    cornerRadii: CGSize(width: 50.0, height: 0.0))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.view.layer.mask = maskLayer
        self.addSubview(view)
    }
    
    @IBAction func AllLessonsTapped(_ sender: Any) {
        self.HideactionHandler()
    }

}
