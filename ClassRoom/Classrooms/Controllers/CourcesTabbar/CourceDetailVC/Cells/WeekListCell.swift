//
//  WeekListCell.swift
//  Classrooms
//
//  Created by Shorupan Pirakaspathy on 2020-04-17.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit

class WeekListCell: UICollectionViewCell {

    @IBOutlet weak var View: CustomView!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var Option: CustomBTN!
    
    func OptionactionHandler(action:(() -> Void)? = nil) {
        struct __ { static var action :(() -> Void)? }
        if action != nil { __.action = action }
        else { __.action?() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func Option(_ sender: Any) {
        self.OptionactionHandler()
    }
}
