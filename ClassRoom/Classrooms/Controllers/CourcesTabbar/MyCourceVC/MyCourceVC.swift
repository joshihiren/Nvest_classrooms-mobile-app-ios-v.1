//
//  MyCourceVC.swift
//  Classrooms
//
//  Created by Shorupan Pirakaspathy on 2020-04-16.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit

class MyCourceVC: BaseVC {
    
    //    MARK:- IBOutlets
    
    @IBOutlet weak var TitleLBL: UILabel!
    @IBOutlet var TopBar: SMTabbar!
    
    @IBOutlet weak var ListView: UIView!
    @IBOutlet weak var TBLView: CustomView!
    @IBOutlet weak var CourceTBL: UITableView!
    
    //    MARK:- Variable Define
    
    var SelectedTag: Int = 0
    var Freefeed_Arry: NSMutableArray!
    var Primefeed_Arry: NSMutableArray!
    var Privatefeed_Arry: NSMutableArray!
    
    lazy var NoMessage: UILabel = {
        () -> UILabel in
        let lbl = UILabel.init(frame: CGRect(x: 20, y: (self.TBLView.frame.width / 2) - 20, width: Screen_width - 40, height: 20))
        lbl.text = "No More Messages"
        lbl.textColor = UIColor.colorWithHexString(hexStr: "57748D")
        lbl.textAlignment = .center
        lbl.isHidden = true
        self.view.addSubview(lbl)
        return lbl
    }()
    
    //    MARK:- View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.colorWithHexString(hexStr: "57748D")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetupTopOptions()
        self.SetupScreen()
    }
    
    //    MARK:- User Define Methods
    
    func SetupTopOptions() {
        let list : [String] = ["All","Static","Interactive"]
        self.TopBar.buttonWidth = 90
        self.TopBar.moveDuration = 0.4
        self.TopBar.fontSize = 16.0
        self.TopBar.linePosition = .top // the color line posistion, default is bottom.
        self.TopBar.backgroundColor = .clear
        self.TopBar.configureSMTabbar(titleList: list) { (index) -> (Void) in
            self.SelectedTag = index
            self.selectedOption(tag: index)
        }
        self.TopBar.viewBGcolor = .white
        self.TopBar.SelectedColor = UIColor.colorWithHexString(hexStr: "57748D")
        self.TopBar.UnselectedColor = UIColor.lightGray
        self.TopBar.fontColor = UIColor.lightGray
        self.TopBar.selectTab(index: 0)
        self.selectedOption(tag: 0)
    }
    
    func SetupScreen() {
        
        self.Freefeed_Arry = NSMutableArray.init()
        self.Primefeed_Arry = NSMutableArray.init()
        self.Privatefeed_Arry = NSMutableArray.init()
        
        for _ in 1...3 {
            self.Freefeed_Arry.add("add")
            self.Primefeed_Arry.add("add")
            self.Privatefeed_Arry.add("add")
        }
        
        self.TitleLBL.text = "My Cources"
        
        self.CourceTBL.register(UINib.init(nibName: "CourceCell", bundle: nil), forCellReuseIdentifier: "CourceCell")
        let footer = UIView.init(frame: CGRect(x: 0, y: 0, width: Screen_width, height: 30))
        footer.backgroundColor = .white
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
                if self.Freefeed_Arry.count == 0 {
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
                if self.Primefeed_Arry.count == 0 {
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
                if self.Privatefeed_Arry.count == 0 {
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
    
}

//MARK:- TableViewDelegate
extension MyCourceVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.SelectedTag == 0 {
            return self.Freefeed_Arry.count
        }
        else if self.SelectedTag == 1 {
            return self.Primefeed_Arry.count
        }
        else {
            return self.Privatefeed_Arry.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CourceCell = tableView.dequeueReusableCell(withIdentifier: "CourceCell") as! CourceCell
        cell.setcolor(color: indexPath.row == 0 ? UIColor.colorWithHexString(hexStr: "85CAF1") : indexPath.row == 1 ? UIColor.colorWithHexString(hexStr: "F4BC82") : UIColor.colorWithHexString(hexStr: "8C88CA") )
        if indexPath.row == 0 {
            cell.TitleLBL.text = "Machine Learning"
            cell.LogoIMG.image = UIImage.init(named: "Machine")
            cell.NoteLBL.text = "STANFORD UNIVERSITY"
            cell.Progress.progress = 0.45
        }
        else if indexPath.row == 1 {
            cell.TitleLBL.text = "Python for everybody"
            cell.LogoIMG.image = UIImage.init(named: "Python")
            cell.NoteLBL.text = "CAMBRIDGE UNIVERSITY"
            cell.Progress.progress = 0.9
        }
        else {
            cell.TitleLBL.text = "Python for everybody"
            cell.LogoIMG.image = UIImage.init(named: "Android")
            cell.NoteLBL.text = "CAMBRIDGE UNIVERSITY"
            cell.Progress.progress = 0.75
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            
        }
        let vc = CourceDetailsVC.init(nibName: "CourceDetailsVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
