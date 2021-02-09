//
//  DemoTableViewCell.swift
//  DPPhotoBrowser
//
//  Created by developeng on 2021/2/5.
//

import UIKit

class DemoTableViewCell: UITableViewCell {

    var _imgArr:Array<String>?
    var imgArr:Array<String>?{
        
        get {
            return _imgArr
        } set {
            _imgArr = newValue
            
            for (idx, item) in _imgArr!.enumerated() {
               
                let buttonW:CGFloat = (self.contentView.frame.width - 10.0 * 3.0)/3.0
                let buttonH:CGFloat = buttonW
                let buttonX:CGFloat = CGFloat(idx % 3) * (buttonW + 10.0)
                let buttonY:CGFloat = CGFloat((idx / 3)) * (buttonH + 10.0)

                let button:UIButton = UIButton.init(type: .custom)
                button.setImage(UIImage(named: item), for: .normal)
                button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
                button.imageView?.contentMode = .scaleAspectFill
                button.tag = idx
                button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
                self.contentView.addSubview(button)
            }
        }
    }
    
    
    @objc func buttonClick(button:UIButton){
        DPPhotoBrowser.showPhotos(imgArr: self.imgArr!,superView: button.superview!,selectIndex: button.tag)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
