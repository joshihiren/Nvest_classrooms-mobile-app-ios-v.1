//
//  CourceCell.swift
//  Classrooms
//
//  Created by Shorupan Pirakaspathy on 2020-04-16.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit

class CourceCell: UITableViewCell {

    @IBOutlet weak var MainView: UIView!
    @IBOutlet weak var BGColor1: CustomLBL!
    @IBOutlet weak var BGColor2: CustomLBL!
    @IBOutlet weak var SubView: CustomView!
    @IBOutlet weak var TypeLBL: UILabel!
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet weak var NoteLBL: UILabel!
    @IBOutlet weak var Progress: UIProgressView!
    @IBOutlet weak var LogoIMG: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setcolor(color: UIColor) {
        self.BGColor1.LBL_BGColor = color
        self.BGColor1.backgroundColor = color
        self.BGColor2.LBL_BGColor = color
        self.BGColor2.backgroundColor = color
        self.SubView.BGColor = color
        self.SubView.backgroundColor = color
        self.LogoIMG.tintColor = .white
    }
    
}
