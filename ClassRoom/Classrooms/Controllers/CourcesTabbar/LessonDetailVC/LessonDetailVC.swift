//
//  LessonDetailVC.swift
//  Classrooms
//
//  Created by Shorupan Pirakaspathy on 2020-04-17.
//  Copyright © 2020 Shorupan Pirakaspathy. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class LessonDetailVC: BaseVC {
    
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
    
    @IBOutlet weak var AllLessonView: CustomView!
    @IBOutlet weak var TypeLBL: UILabel!
    @IBOutlet weak var AlllessonLBL: UIButton!
    
    @IBOutlet weak var BackBTN: UIButton!
    @IBOutlet weak var Back_Top: NSLayoutConstraint!
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var ScrollTitleLBL: UILabel!
    @IBOutlet weak var DetailLBL: UILabel!
    
    @IBOutlet weak var AllLessonpopup: UIView!
    @IBOutlet weak var popup_height: NSLayoutConstraint!
    
    //    MARK:- Variable Define
    
    lazy var Lessonpopup: LessonPopupView = {
        () -> LessonPopupView in
        var view : LessonPopupView!
        let bounds = CGRect(x: 0, y: 0, width: Screen_width, height: 280)
        view = LessonPopupView.init(frame: bounds)
        view.isHidden = true
        self.view.layoutIfNeeded()
        return view
    }()
    
    //    MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetupScreen()
        self.popup_height.constant = 50
        self.Back_Top.constant = 30
    }
    
    //    MARK:- User Define Methods
    
    func SetupScreen() {
        self.TopBezierPath()
//        self.SetupNotesview()
        self.SetupVideoview()
        self.setupDetailView()
    }
    
    func TopBezierPath() {
        let maskPath = UIBezierPath(roundedRect: CGRect.init(x: 0, y: 0, width: Screen_width, height: self.TopView.frame.height),
                                    byRoundingCorners: [.bottomLeft],
                                    cornerRadii: CGSize(width: 50.0, height: 0.0))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.TopView.layer.mask = maskLayer
    }
    
    func SetupNotesview() {
        self.SubView.isHidden = false
        self.VideoView.isHidden = true
        self.LogoIMG.image = UIImage.init(named: "Machine")
        
        self.TitleLBL.text = "My Cources"
    }
    
    func SetupVideoview() {
        self.SubView.isHidden = true
        self.VideoView.isHidden = false
        let videoURL = URL(string: "http://mirrors.standaloneinstaller.com/video-sample/small.mp4")
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.backgroundColor = UIColor.black.cgColor
        playerLayer.videoGravity = AVLayerVideoGravity.resize
        playerLayer.frame = self.VideoView.frame
        self.VideoView.layer.addSublayer(playerLayer)
        player.play()
    }
    
    func setupDetailView() {
        let htmltext: String = "<h1>HTML Ipsum Presents</h1><p><strong>Pellentesque habitant morbi tristique</strong> senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. <em>Aenean ultricies mi vitae est.</em> Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, <code>commodo vitae</code>, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim</a> in turpis pulvinar facilisis. Ut felis.</p><h2>Header Level 2</h2><ol><li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li><li>Aliquam tincidunt mauris eu risus.</li></ol><blockquote><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus magna. Cras in mi at felis aliquet congue. Ut a est eget ligula molestie gravida. Curabitur massa. Donec eleifend, libero at sagittis mollis, tellus est malesuada tellus, at luctus turpis elit sit amet quam. Vivamus pretium ornare est.</p></blockquote><h3>Header Level 3</h3><ul><li>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.</li><li>Aliquam tincidunt mauris eu risus.</li></ul><pre><code>#header h1 a {display: block;width: 300px;height: 80px;}</code></pre><p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p><p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p><p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra. Vestibulum erat wisi, condimentum sed, commodo vitae, ornare sit amet, wisi. Aenean fermentum, elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>"
        self.ScrollTitleLBL.text = ""
        self.DetailLBL.attributedText = htmltext.htmlToAttributedString
    }
    
    func loadAllLesson() {
        self.TopBezierPath()
        self.AllLessonpopup.addSubview(self.Lessonpopup)
        self.view.insertSubview(self.AllLessonpopup, aboveSubview: self.TopView)
        self.Lessonpopup.LessonList.register(UINib.init(nibName: "WeekListCell", bundle: nil), forCellWithReuseIdentifier: "WeekListCell")
        self.Lessonpopup.LessonList.translatesAutoresizingMaskIntoConstraints = false
        self.Lessonpopup.LessonList.delegate = self
        self.Lessonpopup.LessonList.dataSource = self
    }
    
    //    MARK:- API Calling
    
    //    MARK:- IBAction Methods
    
    @IBAction func BackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func AllLessonsTapped(_ sender: Any) {
        self.loadAllLesson()
        self.AllLessonView.isHidden = true
        self.popup_height.constant = 280
        self.Back_Top.constant = 80
        self.Lessonpopup.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.AllLessonpopup.layoutIfNeeded()
        }
        self.Lessonpopup.HideactionHandler {
            self.popup_height.constant = 50
            self.Back_Top.constant = 30
            self.Lessonpopup.isHidden = true
            self.AllLessonView.isHidden = false
        }
    }
    
    func animation() {
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.AllLessonpopup.frame = CGRect.init(x: 0, y: 0, width: Screen_width, height: 280)
                        self.AllLessonView.isHidden = true
                        self.popup_height.constant = 280
                        self.Back_Top.constant = 80
                        self.Lessonpopup.isHidden = false
                        self.Lessonpopup.HideactionHandler {
                            UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseIn],
                                           animations: {
                                            self.AllLessonView.isHidden = false
                                            self.view.layoutIfNeeded()
                            }, completion: { _ in
                                self.popup_height.constant = 50
                                self.Back_Top.constant = 30
                                self.Lessonpopup.isHidden = true
                            })
                        }
                        self.view.layoutIfNeeded()
        }, completion: { _ in
            self.loadAllLesson()
        })
    }
    
}

//MARK: - Extension|UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
extension LessonDetailVC: UICollectionViewDelegate,UICollectionViewDataSource,
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
        UIView.transition(with: self.ScrollView,
                          duration: 0.35,
                          options: .transitionCurlDown,
                          animations:
            { () -> Void in
                self.setupDetailView()
        },completion: nil);
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.Lessonpopup.LessonList.frame.size.width / 2.5, height: self.Lessonpopup.LessonList.frame.size.height)
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
