//
//  CourceDetailsVC.swift
//  Classrooms
//
//  Created by Shorupan Pirakaspathy on 2020-04-17.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit

class CourceDetailsVC: BaseVC {

//    MARK:- IBOutlet
    
    @IBOutlet weak var TopView: UIView!
    
    @IBOutlet weak var SubView: UIView!
    @IBOutlet weak var LogoIMG: UIImageView!
    
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet weak var NoteLBL: UILabel!
    @IBOutlet weak var TimeLBL: UILabel!
    @IBOutlet weak var TimeIMG: UIImageView!
    @IBOutlet weak var Progress: UIProgressView!
    
    @IBOutlet weak var VideoView: UIView!
    
    @IBOutlet weak var TypeLBL: UILabel!
    
    @IBOutlet weak var BackBTN: UIButton!
    
    @IBOutlet weak var detailsview: UIView!
    @IBOutlet var TopBar: SMTabbar!
    @IBOutlet weak var CourceTBL: UITableView!
    
//    MARK:- Variable Define
    
    var SelectedTag: Int = 0
    var Arry: NSMutableArray!
    let RowHeight: CGFloat = 150.0
    
    lazy var NoMessage: UILabel = {
        () -> UILabel in
        let lbl = UILabel.init(frame: CGRect(x: 20, y: (self.CourceTBL.frame.width / 2) - 20, width: Screen_width - 40, height: 20))
        lbl.text = "No More Messages"
        lbl.textColor = UIColor.colorWithHexString(hexStr: "57748D")
        lbl.textAlignment = .center
        lbl.isHidden = true
        self.view.addSubview(lbl)
        return lbl
    }()
    
//    MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetupTopOptions()
        self.SetupScreen()
    }

//    MARK:- User Define Methods

    func SetupTopOptions() {
        let list : [String] = ["Lessons", "Discussion", "Announcements"]
        self.TopBar.buttonWidth = 90
        self.TopBar.moveDuration = 0.4
        self.TopBar.fontSize = 16.0
        self.TopBar.linePosition = .top // the color line posistion, default is bottom.
        self.TopBar.backgroundColor = .clear
        self.TopBar.configureSMTabbar(titleList: list) { (index) -> (Void) in
            self.SelectedTag = index
            self.selectedOption(tag: index)
        }
        self.TopBar.viewBGcolor = UIColor.colorWithHexString(hexStr: "57748D")
        self.TopBar.SelectedColor = .white
        self.TopBar.fontColor = .white
        self.TopBar.UnselectedColor = UIColor.colorWithHexString(hexStr: "57748D")
        self.TopBar.selectTab(index: 0)
        self.selectedOption(tag: 0)
    }
    
    func SetupScreen() {
        
        let maskPath = UIBezierPath(roundedRect: CGRect.init(x: 0, y: 0, width: Screen_width, height: self.TopView.frame.height),
                                    byRoundingCorners: [.bottomLeft],
                                    cornerRadii: CGSize(width: 50.0, height: 0.0))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.TopView.layer.mask = maskLayer
        
        self.Arry = NSMutableArray.init()
        
        for _ in 1...3 {
            self.Arry.add("add")
        }
        
        self.LogoIMG.image = UIImage.init(named: "Machine")
        
        self.TitleLBL.text = "My Cources"
        
        self.CourceTBL.register(UINib.init(nibName: "CourceDetailsCell", bundle: nil), forCellReuseIdentifier: "CourceDetailsCell")
        let footer = UIView.init(frame: CGRect(x: 0, y: 0, width: Screen_width, height: 30))
        footer.backgroundColor = .clear
        self.CourceTBL.tableFooterView = footer
        
        self.CourceTBL.delegate = self
        self.CourceTBL.dataSource = self
        self.CourceTBL.reloadData()
        
    }
    
    func selectedOption(tag: Int) {
        self.SelectedTag = tag
        UIView.transition(with: self.CourceTBL,
                          duration: 0.35,
                          options: .transitionCurlDown,
                          animations:
            { () -> Void in
                self.CheckDataStatus()
        },completion: nil);
    }
    
    func CheckDataStatus() {
        DispatchQueue.main.async {
            if self.SelectedTag == 0 {
                if self.Arry.count == 0 {
                    self.NoMessage.isHidden = false
                    self.CourceTBL.isHidden = true
                }
                else {
                    self.NoMessage.isHidden = true
                    self.CourceTBL.isHidden = false
                    self.CourceTBL.reloadData()
                }
            }
            else if self.SelectedTag == 1 {
                if self.Arry.count == 0 {
                    self.NoMessage.isHidden = false
                    self.CourceTBL.isHidden = true
                }
                else {
                    self.NoMessage.isHidden = true
                    self.CourceTBL.isHidden = false
                    self.CourceTBL.reloadData()
                }
            }
            else {
                if self.Arry.count == 0 {
                    self.NoMessage.isHidden = false
                    self.CourceTBL.isHidden = true
                }
                else {
                    self.NoMessage.isHidden = true
                    self.CourceTBL.isHidden = false
                    self.CourceTBL.reloadData()
                }
            }
        }
    }
    
//    MARK:- IBAction Methods
    
    @IBAction func BackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func SectionTapped() {
        
    }
    
}

//MARK:- TableViewDelegate
extension CourceDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.Arry.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: self.CourceTBL.frame.width, height: 40))
        view.theme_backgroundColor = GlobalPicker.backgroundColor
        
        let stack = UIStackView.init(frame: CGRect.init(x: 0, y: 0, width: self.CourceTBL.frame.width - 20, height: 40))
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 15
        
        let lbl = UILabel.init()
        lbl.text = "Week 1"
        lbl.textColor = UIColor.colorWithHexString(hexStr: "57748D")
        lbl.textAlignment = .left
        
        let btn = UIButton.init()
        btn.setTitle("See all", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica-Light", size: 15)
        btn.setTitleColor(UIColor.colorWithHexString(hexStr: "57748D"), for: .normal)
        btn.tag = section
        btn.addTarget(self, action: #selector(SectionTapped), for: .touchUpInside)
        
        stack.addArrangedSubview(lbl)
        stack.addArrangedSubview(btn)
        
        view.addSubview(stack)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CourceDetailsCell = tableView.dequeueReusableCell(withIdentifier: "CourceDetailsCell") as! CourceDetailsCell
        
        cell.List.register(UINib.init(nibName: "WeekListCell", bundle: nil), forCellWithReuseIdentifier: "WeekListCell")
        cell.List.translatesAutoresizingMaskIntoConstraints = false
        cell.List.delegate = self
        cell.List.dataSource = self
        cell.List.tag = indexPath.section
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.RowHeight //UITableView.automaticDimension
    }
    
}

//MARK: - Extension|UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension CourceDetailsVC: UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekListCell",for: indexPath) as? WeekListCell else { fatalError() }
        self.configdesignCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            
        }
        let vc = LessonDetailVC.init(nibName: "LessonDetailVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.CourceTBL.frame.size.width / 2.5, height: self.RowHeight)
    }
    
    func configdesignCell(cell: WeekListCell, indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            cell.View.backgroundColor = .white
            cell.Title.textColor = UIColor.colorWithHexString(hexStr: "414865")
            cell.note.textColor = UIColor.colorWithHexString(hexStr: "414865")
            cell.Option.backgroundColor = UIColor.colorWithHexString(hexStr: "414865")
            cell.Option.BTN_BGColor = UIColor.colorWithHexString(hexStr: "414865")
            cell.Option.tintColor = .white
            cell.Option.setImage(UIImage.init(named: "SF_checkmark_square_fill"), for: .normal)
            cell.Option.BTN_CornerRadius = 10
        }
        else {
            cell.View.backgroundColor = UIColor.colorWithHexString(hexStr: "414865")
            cell.Title.textColor = .white
            cell.note.textColor = .white
            cell.Option.backgroundColor = .white
            cell.Option.BTN_BGColor = .white
            cell.Option.tintColor = UIColor.colorWithHexString(hexStr: "414865")
            cell.Option.setImage(UIImage.init(named: "SF_play_circle_fill"), for: .normal)
            cell.Option.BTN_isCircle = true
        }
        cell.Image.clipsToBounds = true
        cell.Image.layer.cornerRadius = 20
        cell.Image.image = UIImage.init(named: "Rectangle.png")
        cell.Title.text = "Lesson " + String(indexPath.row)
        cell.note.text = "Introductions"
    }
    
}
