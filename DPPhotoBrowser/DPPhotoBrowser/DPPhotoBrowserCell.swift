//
//  DPPhotoBrowserCell.swift
//  DPPhotoBrowser
//
//  Created by developeng on 2021/2/4.
//

import UIKit

class DPPhotoBrowserCell: UICollectionViewCell {
    
    var tapSingleBlock: ((_ cell:DPPhotoBrowserCell) -> Void)?
    var longPressBlock: ((_ cell:DPPhotoBrowserCell) -> Void)?
    
    var _config:DPPhotoBrowerConfig!
    var config:DPPhotoBrowerConfig! {
        get {
            return _config
        } set {
            _config = newValue
            self.scrollView.minimumZoomScale = _config.minScale
            self.scrollView.maximumZoomScale = _config.maxScale
        }
    }

    lazy var scrollView:UIScrollView = {
        let scrollView:UIScrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.minimumZoomScale = 0.8
        scrollView.maximumZoomScale = 2.0
        scrollView.isUserInteractionEnabled = true
        scrollView.setZoomScale(1.0, animated: true)
        scrollView.delegate = self
        return scrollView
    }()
        
    lazy var imageV:UIImageView = {
        let imageView:UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    var _imgStr:Any = ""
    var imgStr:Any{
        get {
            return _imgStr
        } set {
            _imgStr = newValue
            if _imgStr is UIImage {
                self.imageV.image = _imgStr as? UIImage
            } else {
                if (_imgStr is String) && ((_imgStr as! String).contains("http")) {
                    
                    let url = URL(string: _imgStr as! String)
                    self.imageV.kf.setImage(with: url)
                } else {
                    self.imageV.image = UIImage(named: _imgStr as! String)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(self.scrollView)
        self.scrollView.addSubview(self.imageV)
        
        let tapSingle:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapSingleClick(tap:)))
        tapSingle.numberOfTapsRequired = 1
        tapSingle.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapSingle)

        let tapDouble:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapDoubleClick(tap:)))
        tapDouble.numberOfTapsRequired = 2
        tapDouble.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapDouble)
        
        //此行代码解决单击和双击冲突问题
        tapSingle.require(toFail: tapDouble)
        
        
        let longpress:UILongPressGestureRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressClick(longPress:)))
        self.addGestureRecognizer(longpress)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrollView.frame = self.bounds
        self.adjustFrame()
    }
    
    func adjustFrame() {
        
        var frame:CGRect = self.scrollView.frame
        if self.imageV.image != nil {
            
            let imageSize:CGSize = self.imageV.image!.size
            var imageFrame:CGRect = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
            
            let ratio:CGFloat = frame.size.width / imageFrame.size.width;
            imageFrame.size.height = imageFrame.size.height * ratio;
            imageFrame.size.width = frame.size.width;
            
            self.imageV.frame = imageFrame
            self.scrollView.contentSize = self.imageV.frame.size
            self.imageV.center = self.centerOfScrollViewContent(scrollView: scrollView)
            
            //根据图片大小找到最大缩放等级，保证最大缩放时候，不会有黑边
            var maxScale:CGFloat = frame.size.height / imageFrame.size.height
            maxScale = frame.size.width / imageFrame.size.width > maxScale ? frame.size.width / imageFrame.size.width : maxScale
            //超过了设置的最大的才算数
            maxScale = maxScale > self.config.maxScale ? maxScale : self.config.maxScale
            //初始化
            self.scrollView.minimumZoomScale = self.config.minScale
            self.scrollView.maximumZoomScale = maxScale
            self.scrollView.zoomScale = 1.0

        } else {
            frame.origin = CGPoint.zero
            self.imageV.frame = frame
            self.scrollView.contentSize = self.imageV.frame.size
        }
        self.scrollView.contentOffset = CGPoint.zero
        self.scrollView.zoomScale = 1.0
    }
    
    func aaa()  {
        self.scrollView.setZoomScale(1.0, animated: true)
    }
}

//scrollView的委托
extension DPPhotoBrowserCell:UIScrollViewDelegate {
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.imageV.center = self.centerOfScrollViewContent(scrollView: scrollView)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageV
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        let subView:UIView = self.imageV
        
        let offsetX:CGFloat = (scrollView.bounds.size.width > scrollView.contentSize.width) ?
        (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
        
        let offsetY:CGFloat = (scrollView.bounds.size.height > scrollView.contentSize.height) ?
        (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
        
        subView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y:  scrollView.contentSize.height * 0.5 + offsetY)
    }
}



//手势处理
extension DPPhotoBrowserCell {
    
    @objc func tapSingleClick(tap:UITapGestureRecognizer){
        if self.tapSingleBlock != nil {
            self.tapSingleBlock!(self)
        }
    }
    @objc func tapDoubleClick(tap:UITapGestureRecognizer){
        
        let touchPoint:CGPoint = tap.location(in: self)
        if self.scrollView.zoomScale <= 1.0 {
            let scaleX = touchPoint.x + self.scrollView.contentOffset.x
            let scaleY = touchPoint.y + self.scrollView.contentOffset.y
            self.scrollView.zoom(to: CGRect(x: scaleX, y: scaleY, width: 10, height: 10), animated: true)
        } else {
            self.scrollView.setZoomScale(1.0, animated: true)
        }
    }
    
    
    @objc func longPressClick(longPress:UILongPressGestureRecognizer){
        if longPress.state == .began {
            if self.longPressBlock != nil {
                self.longPressBlock!(self)
            }
        }
    }

    //2.双击的放大时，获取图片在中间的位置
    
    func centerOfScrollViewContent(scrollView:UIScrollView) -> CGPoint {
        
        let offsetX:CGFloat = (scrollView.frame.size.width > scrollView.contentSize.width) ? (scrollView.frame.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
        
        let offsetY:CGFloat = (scrollView.frame.size.height > scrollView.contentSize.height) ? (scrollView.frame.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
        
        let actualCenter:CGPoint = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX, y:  scrollView.contentSize.height * 0.5 + offsetY)
        
        return actualCenter
    }
    
    
    
    
    
    
}
