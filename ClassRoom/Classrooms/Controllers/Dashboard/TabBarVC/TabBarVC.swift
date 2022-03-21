//
//  TabBarVC.swift
//  ClassRoom
//
//  Created by Shorupan Pirakaspathy on 2020-04-08.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit

class TabBarVC: BaseVC {
    
    //    MARK:- IBOutlet
    @IBOutlet weak var TabBGview: UIView!
    
    @IBOutlet weak var TabView: UIView!
    
    @IBOutlet weak var Tab1BTN: UIButton!
    
    @IBOutlet weak var Tab2BTN: UIButton!
    
    @IBOutlet weak var Tab3BTN: UIButton!
    
    //    MARK:- Variable Define
    
    var containerController: SwiftyPageController!
    
    //    MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //    MARK:- UserDefine Methods
    
    func setupContainerController(_ controller: SwiftyPageController) {
        // assign variable
        containerController = controller
        
        // set delegate
        containerController.delegate = self
        
        // set animation type
        containerController.animator = .default
        
        // set view controllers
        let v1 = Tab1VC.init(nibName: "Tab1VC", bundle: nil)
        let v2 = HomeViewController.init(nibName: "HomeViewController", bundle: nil)
        let v3 = ProfileVC.init(nibName: "ProfileVC", bundle: nil)
        
        containerController.viewControllers = [v1, v2, v3]
        
        // select needed controller
        containerController.selectController(atIndex: 0, animated: false)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let containerController = segue.destination as? SwiftyPageController {
            setupContainerController(containerController)
        }
    }
    
    // MARK: - IBAction Methods
    
    @IBAction func TappedTab1(_ sender: Any) {
        containerController.selectController(atIndex: 0, animated: true)
    }
    
    @IBAction func TappedTab2(_ sender: Any) {
        containerController.selectController(atIndex: 1, animated: true)
    }
    
    @IBAction func TappedTab3(_ sender: Any) {
        containerController.selectController(atIndex: 2, animated: true)
    }
    
}

// MARK: - PagesViewControllerDelegate

extension TabBarVC: SwiftyPageControllerDelegate {
    
    func swiftyPageController(_ controller: SwiftyPageController, alongSideTransitionToController toController: UIViewController) {
        
    }
    
    func swiftyPageController(_ controller: SwiftyPageController, didMoveToController toController: UIViewController) {
        //        segmentControl.selectedSegmentIndex = containerController.viewControllers.index(of: toController)!
    }
    
    func swiftyPageController(_ controller: SwiftyPageController, willMoveToController toController: UIViewController) {
        
    }
    
}
