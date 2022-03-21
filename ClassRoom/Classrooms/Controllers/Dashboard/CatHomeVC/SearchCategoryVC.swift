//
//  SearchCategoryVC.swift
//  ClassRoom
//
//  Created by Shorupan Pirakaspathy on 2020-04-09.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding


class SearchCategoryVC: BaseVC {
    
    //    MARK:- IBOutlet
    
    @IBOutlet weak var TopView: UIView!
    @IBOutlet weak var TitleLBL: UILabel!
    
    @IBOutlet weak var SearchView: CustomView!
    @IBOutlet weak var TXTSearch: UITextField!
    @IBOutlet weak var SearchBTN: CustomBTN!
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterLBL: UILabel!
    @IBOutlet weak var filterBTN: UIButton!
    
    @IBOutlet weak var SuggestCollection: UICollectionView!
    @IBOutlet weak var Suggestion_Height: NSLayoutConstraint!
    
    //    MARK:- Variable Define
    
    lazy var cellWidth:CGFloat = SuggestCollection.frame.size.width / 3.5
    lazy var cellHeight:CGFloat = SuggestCollection.frame.size.height
    
    lazy var layout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: self.cellWidth, height: self.cellHeight)
        return flowLayout
    }()
    
    var searchActive: Bool = false
    let chooseDropDown = DropDown()
    var Suggetion_Arry: NSMutableArray!
    
    //    MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetupView()
    }
    
    //    MARK:- User Define Methods
    
    func SetupView() {
        
        KeyboardAvoiding.avoidingView = self.TopView
        
        self.SetSearchTitleMSG(MSG1: "Classroom Search", MSG2: "\nJust Type In What You Want To Find.\n (ex.A Teacher, Subject, or Specific Classroom)")
        self.Suggestion_Height.constant = 0
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) { [weak self] in
            self!.TXTSearch.becomeFirstResponder()
        }
        
        self.TXTSearch.attributedPlaceholder =
        NSAttributedString(string: "Search...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        let toolbar = UIToolbar.init(frame: CGRect(origin: .zero, size: .init(width: view.frame.width, height: 30)))
        let flexpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBTN = UIBarButtonItem(title: "Done".localized(), style: .done, target: self, action: #selector(TappedSearch))
        toolbar.setItems([flexpace, doneBTN], animated: true)
        toolbar.sizeToFit()
        
        self.TXTSearch.inputAccessoryView = toolbar
        self.TXTSearch.delegate = self
        
        self.filterLBL.text = "ALL"
        self.setupChooseDropDown()
        
        self.Suggetion_Arry = NSMutableArray.init()
        self.SuggestCollection.register(UINib.init(nibName: "SuggestCell", bundle: nil), forCellWithReuseIdentifier: "SuggestCell")
        self.SuggestCollection.translatesAutoresizingMaskIntoConstraints = false
        
        self.SuggestCollection.delegate = self
        self.SuggestCollection.dataSource = self
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(DoneBTNAction))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
    }
    
    func SetSearchTitleMSG(MSG1: String, MSG2: String) {
//        let updateTMSG = string1.replacingOccurrences(of: "Time Message", with: UserUtility.GetTimeMessage())
//        let updateUser = updateTMSG.replacingOccurrences(of: "Kelly", with: "Kelly")
        let mainstring: String = MSG1 + MSG2
        let myMutableString: NSMutableAttributedString = mainstring.Attributestring(attribute: [
            (MSG1, UIFont.boldSystemFont(ofSize: 28), UIColor.colorWithHexString(hexStr: AppDarkHex)),
            (MSG2, UIFont.systemFont(ofSize: 15), UIColor.colorWithHexString(hexStr: "344356"))
        ], with: mainstring, with: NSArray.init(array: mainstring.FindSubString(inputStr: mainstring, subStrings: [MSG1, MSG2]))) as! NSMutableAttributedString
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(GetModel.Linespace.value())
        paragraphStyle.alignment = NSTextAlignment.center
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        self.TitleLBL.attributedText = myMutableString
    }
    
    func setupChooseDropDown() {
        self.chooseDropDown.anchorView = self.filterBTN
        
        // By default, the dropdown will have its origin on the top left corner of its anchor view
        // So it will come over the anchor view and hide it completely
        // If you want to have the dropdown underneath your anchor view, you can do this:
        self.chooseDropDown.bottomOffset = CGPoint(x: 0, y: self.filterBTN.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        self.chooseDropDown.dataSource = [
            "All",
            "Pulse",
            "Classroom"
        ]
        self.chooseDropDown.selectRow(0)
        // Action triggered on selection
        self.chooseDropDown.selectionAction = { [weak self] (index, item) in
            self!.filterLBL.text = item
        }
    }
    
//    MARK:- Api Calling
    
    func GetSuggestion(searchvalue: String) {
        if searchvalue.count > 0 {
            self.SetSearchTitleMSG(MSG1: "Search Anything", MSG2: "\t")
            self.Suggetion_Arry.removeAllObjects()
            
            let paramDict = SearchCatParamDict.init(SearchSTR: searchvalue, dropType: self.chooseDropDown.selectedItem!)
            
            NetworkingRequests.shared.NetworkPostrequestJSON(PlistKey.SearchClassroomAPI, Parameters: paramDict.description, Headers: AppUtillity.shared.Getheader(), onSuccess: { (responseObject, statuscode) in
                if statuscode {
                    self.Suggestion_Height.constant = 150
                    self.SuggestCollection.reloadData()
                    self.Suggetion_Arry.add("some data")
                }
                else {
                    self.Suggetion_Arry.removeAllObjects()
                    self.Suggestion_Height.constant = 0
                }
            }) { (msg, code) in
                self.Suggetion_Arry.removeAllObjects()
                self.Suggestion_Height.constant = 0
            }
        }
        else {
            self.Suggetion_Arry.removeAllObjects()
            self.SetSearchTitleMSG(MSG1: "Classroom Search", MSG2: "\nJust Type In What You Want To Find.\n (ex.A Teacher, Subject, or Specific Classroom)")
            self.Suggestion_Height.constant = 0
        }
    }
    
    //    MARK:- IBAction Methods
    
    @objc override func DoneBTNAction () {
//        self.view.endEditing(true)
//        self.TXTSearch.resignFirstResponder()
    }
    
    @IBAction func TappedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func TappedSearch(_ sender: Any) {
        self.view.endEditing(true)
        self.TXTSearch.resignFirstResponder()
        if self.TXTSearch.text!.count > 0 {
            self.GetSuggestion(searchvalue: self.TXTSearch.text!)
        }
    }
    
    @IBAction func Tappedfilter(_ sender: Any) {
        self.chooseDropDown.show()
    }
    
}

//MARK: - Extension|UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension SearchCategoryVC: UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.Suggetion_Arry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestCell",for: indexPath) as? SuggestCell else { fatalError() }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.cellWidth, height: self.cellHeight)
    }
}

//MARK:- Textfield Delegates
extension SearchCategoryVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = textField.text! as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString

        self.GetSuggestion(searchvalue: newString as String)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text!.count > 0 || self.Suggetion_Arry.count > 0 {
            self.SetSearchTitleMSG(MSG1: "Search Anything", MSG2: "\t")
            self.Suggestion_Height.constant = 150
            self.SuggestCollection.reloadData()
        }
        else {
            self.SetSearchTitleMSG(MSG1: "Classroom Search", MSG2: "\nJust Type In What You Want To Find.\n (ex.A Teacher, Subject, or Specific Classroom)")
            self.Suggestion_Height.constant = 0
        }
        return true
    }
    
}
