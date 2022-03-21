//
//  TutorialListVC.swift
//  Classrooms
//
//  Created by Shorupan Pirakaspathy on 2020-04-10.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit

class TutorialListVC: BaseVC {
    
    //    MARK:- IBOutlet
    
    @IBOutlet weak var TopView: UIView!
    
    @IBOutlet weak var CenterView: UIView!
    @IBOutlet weak var Center_Height: NSLayoutConstraint!
    
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet weak var SubtitleLBL: UILabel!
    @IBOutlet weak var DesignCollection: UICollectionView!
    @IBOutlet weak var Design_Height: NSLayoutConstraint!
    
    @IBOutlet weak var CategoryLBL: UILabel!
    @IBOutlet weak var CategoryCollection: UICollectionView!
    
    //    MARK:- Variable Define
    
    var searchActive: Bool = false
    var Categoryname: String!
    
    //    MARK:- View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isIphone5 {
            self.Center_Height.constant = Screen_height - 30
//            self.Design_Height.constant = Screen_height * 0.30
        }
        else if isIphone6 {
            let height = Screen_height / 1.2
            self.Center_Height.constant = height
//            self.Design_Height.constant = height * 0.30
        }
        else {
            let height = Screen_height / 1.7
            self.Center_Height.constant = height
//            self.Design_Height.constant = height * 0.30
        }
        self.loadViewIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetupView()
    }
    
    //    MARK:- User Define Methods
    
    func SetupView() {
        
        let maskPath = UIBezierPath(roundedRect: CGRect.init(x: 0, y: 0, width: Screen_width, height: self.TopView.frame.height),
                                    byRoundingCorners: [.bottomLeft],
                                    cornerRadii: CGSize(width: 50.0, height: 0.0))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.TopView.layer.mask = maskLayer
        
        self.TitleLBL.text = "Biology & The Scientific Mind"
        self.SubtitleLBL.text = "User Name"
        
        self.DesignCollection.register(UINib.init(nibName: "DesignCell", bundle: nil), forCellWithReuseIdentifier: "DesignCell")
        self.DesignCollection.translatesAutoresizingMaskIntoConstraints = false
        self.DesignCollection.delegate = self
        self.DesignCollection.dataSource = self
        
        self.CategoryLBL.text = "In This Classroom"
        
        self.CategoryCollection.register(UINib.init(nibName: "TutorialRoomCell", bundle: nil), forCellWithReuseIdentifier: "TutorialRoomCell")
        self.CategoryCollection.translatesAutoresizingMaskIntoConstraints = false
        self.CategoryCollection.delegate = self
        self.CategoryCollection.dataSource = self
        
        //
        
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
//    MARK:- Api Calling
    
    func DesignApiCall() {
        let paramDict = DesignCalssParamDict.init(SearchSTR: "")
        
        NetworkingRequests.shared.NetworkPostrequestJSON(PlistKey.CategoryDetailDesignAPI, Parameters: paramDict.description, Headers: AppUtillity.shared.Getheader(), onSuccess: { (responseObject, statuscode) in
            if statuscode {
                
            }
            else {
                
            }
        }) { (msg, code) in
            
        }
    }
    
    func TutorialApiCall() {
        let paramDict = TutorialParamDict.init(SearchSTR: "")
        
        NetworkingRequests.shared.NetworkPostrequestJSON(PlistKey.CategoryClassesAPI, Parameters: paramDict.description, Headers: AppUtillity.shared.Getheader(), onSuccess: { (responseObject, statuscode) in
            if statuscode {
                
            }
            else {
                
            }
        }) { (msg, code) in
            
        }
    }
    
    //    MARK:- IBAction Methods
    
    
}

//MARK: - Extension|UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension TutorialListVC: UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.DesignCollection {
            return 2
        }
        else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.DesignCollection {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DesignCell",for: indexPath) as? DesignCell else { fatalError() }
            self.configdesignCell(cell: cell, indexPath: indexPath)
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TutorialRoomCell",for: indexPath) as? TutorialRoomCell else { fatalError() }
            self.configtutorialCell(cell: cell, indexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let detail = MyCourceVC.init(nibName: "MyCourceVC", bundle: nil)
        let vc = App?.getCourceTab()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.DesignCollection {
            return CGSize(width: self.DesignCollection.frame.size.width / 1.5, height: self.DesignCollection.frame.size.height)
        }
        else {
            return CGSize(width: self.CategoryCollection.frame.size.width / 2.5, height: self.CategoryCollection.frame.size.height)
        }
    }
    
    func configdesignCell(cell: DesignCell, indexPath: IndexPath) {
        
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.DesignCollection.frame.size.width / 1.5, height: self.DesignCollection.frame.size.height),
                                    byRoundingCorners: [.bottomLeft, .topRight],
                                    cornerRadii: CGSize(width: 50.0, height: 0.0))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        cell.SubView.layer.mask = maskLayer
        
        if indexPath.row == 0 {
            cell.SubView.backgroundColor = UIColor.colorWithHexString(hexStr: "F87959")
        }
        else {
            cell.SubView.backgroundColor = UIColor.colorWithHexString(hexStr: "5464F1")
        }
    }
    
    func configtutorialCell(cell: TutorialRoomCell, indexPath: IndexPath) {
        
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.CategoryCollection.frame.size.width / 2.5, height: self.CategoryCollection.frame.size.height),
                                    byRoundingCorners: [.bottomLeft, .topRight],
                                    cornerRadii: CGSize(width: 50.0, height: 0.0))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        cell.Subview.layer.mask = maskLayer
        
        if indexPath.row == 0 {
            cell.Subview.backgroundColor = UIColor.colorWithHexString(hexStr: "71CAC5")
            cell.TitleLBL.text = "Roadmap"
        }
        else if indexPath.row == 1 {
            cell.Subview.backgroundColor = UIColor.colorWithHexString(hexStr: "AE71CA")
            cell.TitleLBL.text = "Chat"
        }
        else {
            cell.Subview.backgroundColor = UIColor.colorWithHexString(hexStr: "F8DF59")
            cell.TitleLBL.text = "Design Think"
        }
    }
    
}
