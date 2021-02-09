//
//  DPSheetView.swift
//  DPPhotoBrowser
//
//  Created by developeng on 2021/2/8.
//

import UIKit


public typealias DPPopupItemClickBlock = (_ index:Int,_ title:String) -> Void
public typealias DPPopupVoidBlock = () -> Void


class DPSheetView: UIView {
    
    private var backgroundView:UIView!
    private var contentView:UIView!
    private var buttonView:UIScrollView!
    private var titleLabel:UILabel?
    private var buttonArray:[UIView] = []
    private var cancelButton:UIButton!
    private var buttonTitleArray:[String] = []
    private var title:String!
    private var cancelButtonTitle:String!
    private var itemBlock:DPPopupItemClickBlock?
    private var cancelBlock:DPPopupVoidBlock?
    
    
    private var contentViewWidth:CGFloat = 0
    private var contentViewHeight:CGFloat = 0
    private var buttonViewHeight:CGFloat = 0
    
    class func sheet(title:String?,cancelTitle:String?,itemTitles:[String],itemBlock:DPPopupItemClickBlock? = nil,cancelBlock:DPPopupVoidBlock? = nil) -> DPSheetView {
        let sheetView = DPSheetView.init(frame: CGRect(x: 0, y: 0, width: DP_SCREEN_WIDTH, height: DP_SCREEN_HEIGHT))
        sheetView.setupUI(title: title, cancelTitle: cancelTitle,itemTitles: itemTitles, itemBlock: itemBlock, cancelBlock: cancelBlock)
        return sheetView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension DPSheetView {
    func setupUI(title:String?,cancelTitle:String?,itemTitles:[String],itemBlock:DPPopupItemClickBlock? = nil,cancelBlock:DPPopupVoidBlock? = nil) {
        
        self.backgroundColor = UIColor.clear
        self.title = title
        self.cancelButtonTitle = cancelTitle
        self.buttonTitleArray = itemTitles
        self.itemBlock = itemBlock
        self.cancelBlock = cancelBlock
        self.initContentView()
        
        let tapSingle:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapSingleClick(tap:)))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapSingle)
    }
    
    func initContentView() {
        
        self.contentViewWidth = self.frame.size.width
        self.contentViewHeight = 0
        self.buttonViewHeight = 0
        
        self.contentView = {
            let contentView:UIView = UIView()
            contentView.backgroundColor = UIColor.clear
            return contentView
        }()
        
        self.buttonView = {
            let scrollView:UIScrollView = UIScrollView()
            scrollView.backgroundColor = UIColor.white
            return scrollView
        }()
       
        self.initTitle()
        self.initButtons()
        self.initCancelButton()
        
        
        contentView.frame = CGRect(x: (self.frame.size.width - contentViewWidth) / 2.0, y: self.frame.size.height, width: contentViewWidth, height: contentViewHeight)
        addSubview(self.contentView)
    }
    
    func initTitle() {
        if self.title != nil && !self.title.isEmpty {
            self.titleLabel = {
                let label:UILabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: DP_SCREEN_WIDTH, height: 50))
                label.text = self.title
                label.textAlignment = .center
                label.textColor = UIColor.black
                label.font = UIFont.systemFont(ofSize: 15)
                label.backgroundColor = UIColor.white
                return label
            }()
            self.buttonView.addSubview(self.titleLabel!)
            self.contentViewHeight += (self.titleLabel?.frame.size.height)!
            self.buttonViewHeight += (self.titleLabel?.frame.size.height)!
        }
    }
    func initButtons() {
        if self.buttonTitleArray.count > 0 {
            for item in self.buttonTitleArray {
                let line:UIView = UIView.init(frame: CGRect(x: 0, y: buttonViewHeight, width: contentViewWidth, height: 1))
                line.backgroundColor = UIColor(red: 230.0 / 255.0, green: 230.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0)
                self.buttonView.addSubview(line)
                
                let button:UIButton = UIButton.init(type: .custom)
                button.frame = CGRect(x: 0, y: buttonViewHeight + 1, width: contentViewWidth, height: 52)
                button.backgroundColor = UIColor.white
                button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
                button.setTitle(item, for: .normal)
                button.setTitleColor(UIColor(red: 45 / 255.0, green: 45 / 255.0, blue: 45 / 255.0, alpha: 1.0), for: .normal)
                button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
                self.buttonArray.append(button)
                self.buttonView.addSubview(button)
                self.buttonViewHeight += line.frame.size.height + button.frame.size.height;
            }
            
            self.buttonView.contentSize = CGSize(width: contentViewWidth, height: buttonViewHeight)
            if buttonViewHeight > self.frame.size.height-100 {
                buttonViewHeight = self.frame.size.height-100;
            }
            contentViewHeight = buttonViewHeight;
            buttonView.frame = CGRect(x: 0, y: 0, width: contentViewWidth, height: contentViewHeight)
            self.contentView.addSubview(buttonView)
        }
    }
    func initCancelButton() {
        
        if self.cancelButtonTitle != nil && !self.cancelButtonTitle.isEmpty {
            self.cancelButton = UIButton.init(type: .custom)
            self.cancelButton.frame = CGRect(x: 0, y: contentViewHeight + 5, width: contentViewWidth, height: 52)
            self.cancelButton.backgroundColor = UIColor.white
            self.cancelButton.titleLabel?.font  = UIFont.systemFont(ofSize: 18)
            self.cancelButton.setTitle(self.cancelButtonTitle, for: .normal)
            self.cancelButton.setTitleColor(UIColor(red: 45 / 255.0, green: 45 / 255.0, blue: 45 / 255.0, alpha: 1.0), for: .normal)
            self.cancelButton.addTarget(self, action: #selector(cancelBtnClick(button:)), for: .touchUpInside)
            self.contentView.addSubview(self.cancelButton)
            contentViewHeight += 5 + self.cancelButton.frame.size.height
            
        }
    }
}

extension DPSheetView {
    
    @objc func tapSingleClick(tap:UITapGestureRecognizer){
        self.hide()
    }
    
    @objc func buttonClick(button:UIButton){
        if self.itemBlock != nil {
            self.itemBlock!(button.tag, (button.titleLabel?.text)!)
        }
        self.hide()
    }
    
    @objc func cancelBtnClick(button:UIButton){
        if self.cancelBlock != nil {
            self.cancelBlock!()
        }
        self.hide()
    }
    
    func show() {
        let keyWindow:UIWindow = UIApplication.shared.keyWindow!
        keyWindow.addSubview(self)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.contentView.frame = CGRect(x: self.contentView.frame.origin.x, y: self.frame.size.height - self.contentView.frame.size.height, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
        } completion: { (finished:Bool) in
            
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.contentView.frame = CGRect(x: 0, y: DP_SCREEN_HEIGHT, width: DP_SCREEN_WIDTH, height: DP_SCREEN_HEIGHT - 100)
        } completion: { (finished:Bool) in
            self.removeFromSuperview()
        }
    }
}
