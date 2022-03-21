//
//  ProfileVC.swift
//  ClassRoom
//
//  Created by Shorupan Pirakaspathy on 2020-04-08.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit

class ProfileVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func CloseTapped(_ sender: Any) {
        UserInfoData.shared.UserLogout()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
