//
//  CategoryCell.swift
//  ClassRoom
//
//  Created by Shorupan Pirakaspathy on 2020-04-08.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var SubView: CustomView!
    @IBOutlet weak var Banner: UIImageView!
    @IBOutlet weak var Icon: UIImageView!
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet weak var PriceLBL: UILabel!
    @IBOutlet weak var DetailsLBL: UILabel!
    @IBOutlet weak var MemberLBL: UILabel!
    @IBOutlet weak var Title_Leading: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
