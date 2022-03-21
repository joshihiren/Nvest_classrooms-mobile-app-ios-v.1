//
//  HomeViewController.swift
//  ClassRoom
//
//  Created by Shorupan Pirakaspathy on 2020-04-09.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit

let string1: String = "Time Message Kelly"
let string2: String = "\nBrowse Through The Largest Library Of \nVirtual Learning Centres In The World"
let SearchSTR: String = "What Do You Want To Learn?"
public enum GetModel {
    case Linespace
    case height
    
    func value() -> Int {
        switch self {
        case .Linespace:
            if isIphone5 {
                return 2
            }
            else if isIphone6 {
                return 15
            }
            else {
                return 20
            }
        case .height:
            if isIphone5 {
                return 200
            }
            else if isIphone6 {
                return 300
            }
            else {
                return 350
            }
        }
    }
}


class HomeViewController: BaseVC {
    
    //    MARK:- IBOutlet
    
    @IBOutlet weak var Scrollview: TPKeyboardAvoidingScrollView!
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet weak var SearchView: CustomView!
    @IBOutlet weak var SearchLBL: UILabel!
    @IBOutlet weak var SearchBTN: CustomBTN!
    
    @IBOutlet weak var CategoryLBL: UILabel!
    @IBOutlet weak var CategoryCollection: UICollectionView!
    @IBOutlet weak var List_Height: NSLayoutConstraint!
    
    //    MARK:- Variable Define
    
    lazy var cellWidth:CGFloat = CategoryCollection.frame.size.width / 1.5
    lazy var cellHeight:CGFloat = CategoryCollection.frame.size.height
    
    lazy var layout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: self.cellWidth, height: self.cellHeight)
        return flowLayout
    }()
    
    //    MARK:- View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.List_Height.constant = CGFloat(GetModel.height.value())
        self.Scrollview.contentSize = CGSize(width: Screen_width, height: self.TopView.frame.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetupView()
    }
    
    //    MARK:- User Define Methods
    
    func SetupView() {
        
        let updateTMSG = string1.replacingOccurrences(of: "Time Message", with: UserUtility.GetTimeMessage())
        let updateUser = updateTMSG.replacingOccurrences(of: "Kelly", with: "Kelly")
        let mainstring: String = updateUser + string2
        let myMutableString: NSMutableAttributedString = mainstring.Attributestring(attribute: [
            (updateUser, UIFont.boldSystemFont(ofSize: 28), UIColor.colorWithHexString(hexStr: "344356")),
            (string2, UIFont.systemFont(ofSize: 15), UIColor.colorWithHexString(hexStr: "344356"))
        ], with: mainstring, with: NSArray.init(array: mainstring.FindSubString(inputStr: mainstring, subStrings: [updateUser, string2]))) as! NSMutableAttributedString
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(GetModel.Linespace.value())
        paragraphStyle.alignment = NSTextAlignment.center
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        self.TitleLBL.attributedText = myMutableString
        
        self.SearchLBL.text = SearchSTR
        
        self.CategoryLBL.text = "ALL CLASSROOMS"
        
        self.CategoryCollection.register(UINib.init(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        self.CategoryCollection.translatesAutoresizingMaskIntoConstraints = false
        
        self.CategoryCollection.delegate = self
        self.CategoryCollection.dataSource = self

        
    }
    
    //    MARK:- Api Calling
    
    func HomeApiCall() {
        let paramDict = AllCalssParamDict.init(SearchSTR: "")
        
        NetworkingRequests.shared.NetworkPostrequestJSON(PlistKey.AllClassroomAPI, Parameters: paramDict.description, Headers: AppUtillity.shared.Getheader(), onSuccess: { (responseObject, statuscode) in
            if statuscode {
                
            }
            else {
                
            }
        }) { (msg, code) in
            
        }
    }
    
    //    MARK:- IBAction Methods
    
    @IBAction func TappedSearch(_ sender: Any) {
        let vc = SearchCategoryVC.init(nibName: "SearchCategoryVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - Extension|UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell",for: indexPath) as? CategoryCell else { fatalError() }
        
        if indexPath.row == 0 {
            cell.TitleLBL.text = "Science"
        } else if indexPath.row == 2 {
            cell.TitleLBL.text = "Trending"
        } else if indexPath.row == 3 {
            cell.TitleLBL.text = "Subcription"
        } else if indexPath.row == 4 {
            cell.TitleLBL.text = "Crypto"
        } else {
            cell.TitleLBL.text = "Pulse"
        }
        
        cell.Title_Leading.constant = 17
        cell.Icon.isHidden = true
        cell.PriceLBL.isHidden = true
        cell.MemberLBL.text = "13 Classrooms"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = HomeDetailVC.init(nibName: "HomeDetailVC", bundle: nil)
        if indexPath.row == 0 {
            detail.Categoryname = "Science"
        } else if indexPath.row == 2 {
            detail.Categoryname = "Trending"
        } else if indexPath.row == 3 {
            detail.Categoryname = "Subcription"
        } else if indexPath.row == 4 {
            detail.Categoryname = "Crypto"
        } else {
            detail.Categoryname = "Pulse"
        }
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.cellWidth, height: self.cellHeight)
    }
}
