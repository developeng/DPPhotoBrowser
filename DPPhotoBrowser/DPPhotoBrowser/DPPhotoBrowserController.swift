//
//  DPPhotoBrowserController.swift
//  DPPhotoBrowser
//
//  Created by developeng on 2021/2/4.
//

import UIKit
import Kingfisher

class DPPhotoBrowserController: UIViewController {
    
    weak var sourceImagesContainerView:UIView!
    var currentPage:Int!
    var countImage:Int!
    var config:DPPhotoBrowerConfig!{
        didSet {
            self.titleLabel.isHidden = config.isHiddenTitle
            self.pageControl.isHidden = config.isHiddenPageControl
        }
    }
    
    lazy var titleLabel:UILabel = {
        let label:UILabel = UILabel.init()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 50.0/255.0)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout:UICollectionViewFlowLayout  = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        
        let collectionView:UICollectionView = UICollectionView.init(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.black
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    //底部分页指示器
    lazy var pageControl:UIPageControl = {
        let pageControl: UIPageControl = UIPageControl.init()
        return pageControl
    }()
    
    
    
    lazy var imgArr: [Any] = {
        let arr = [Any]()
        return arr
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.pageControl)
        self.view.addSubview(self.titleLabel)
        self.collectionView.frame = self.view.frame
        self.pageControl.frame = CGRect(x: 0, y: DP_SCREEN_HEIGHT-60, width: DP_SCREEN_WIDTH, height: 40)
        self.titleLabel.frame = CGRect(x: (DP_SCREEN_WIDTH - 100.0)/2.0, y:DP_NAVBAR_HEIGHT , width: 80, height: 30)
        self.titleLabel.layer.cornerRadius = 15
        self.titleLabel.layer.masksToBounds = true
        
        self.loadDatas()
    }
    
    
    func loadDatas() {
        self.pageControl.numberOfPages = self.imgArr.count
        self.pageControl.currentPage = self.currentPage
        self.titleLabel.text = "\((self.currentPage + 1)) / \(self.imgArr.count)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showPhotoBrowser()
    }
    
    func show() {
        self.modalPresentationStyle = .fullScreen;
        UIApplication.shared.keyWindow?.rootViewController?.present(self, animated: false, completion: nil)
    }
    
    func scrollToItem(index:Int) {
        collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: false)
    }
}

extension DPPhotoBrowserController: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier:String = "\(indexPath.section)" + "\(indexPath.row)"
        collectionView.register(DPPhotoBrowserCell.classForCoder(), forCellWithReuseIdentifier: identifier)
        let cell:DPPhotoBrowserCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DPPhotoBrowserCell
        let item = self.imgArr[indexPath.item]
        cell.config = self.config
        cell.imgStr = item
        cell.tapSingleBlock = {[weak self] (currentCell:DPPhotoBrowserCell) -> Void in
            self?.hidePhotoBrower(cell: currentCell)
        }
        cell.longPressBlock = {(currentCell:DPPhotoBrowserCell) -> Void in
            if self.config.isSaveImg {
                self.saveImageSheet(image: currentCell.imageV.image!)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageCount:Int = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        self.currentPage = pageCount
        self.pageControl.currentPage = self.currentPage
        self.titleLabel.text = "\((self.currentPage + 1)) / \(self.imgArr.count)"
    }
}

extension DPPhotoBrowserController {
    
    //MARK -- 显示图片
    func showPhotoBrowser() {
        
        let sourceView:UIView  = self.sourceImagesContainerView.subviews[self.currentPage]
        let parentView:UIView = self.view.getParsentView(view: sourceView)
        let rect:CGRect = (sourceView.superview?.convert(sourceView.frame, to: parentView))!
        
        let tempImageView:UIImageView = UIImageView()
        tempImageView.frame = rect
        
        let item = self.imgArr[self.currentPage]
        if item is UIImage {
            tempImageView.image = item as? UIImage
        } else {
            if (item is String) && ((item as! String).contains("http")) {
                let url = URL(string: item as! String)
                tempImageView.kf.setImage(with: url)
            } else {
                tempImageView.image = UIImage(named: item as! String)
            }
        }
        self.view.addSubview(tempImageView)
        tempImageView.contentMode = .scaleAspectFit
        
        var targetTemp:CGRect;
        targetTemp = CGRect(x: 0, y:0, width: DP_SCREEN_WIDTH, height: DP_SCREEN_HEIGHT)
        self.collectionView.isHidden = true
        UIView.animate(withDuration: 0.25) {
            tempImageView.frame = targetTemp
            
        } completion: { (finished:Bool) in
            tempImageView.removeFromSuperview()
            self.collectionView.isHidden = false
        }
    }
    
    //MARK -- 单击隐藏图片
    func hidePhotoBrower(cell:DPPhotoBrowserCell) {
        
        let currentImageView:UIImageView = cell.imageV
        
        let sourceView:UIView  = self.sourceImagesContainerView.subviews[self.currentPage]
        let parentView:UIView = self.view.getParsentView(view: sourceView)
        let targetTemp:CGRect = (sourceView.superview?.convert(sourceView.frame, to: parentView))!
        
        let tempImageView:UIImageView = UIImageView()
        tempImageView.image = currentImageView.image;
        
        if (tempImageView.image == nil) {
            tempImageView.backgroundColor = UIColor.white
        }
        
        tempImageView.frame = currentImageView.frame;
        self.view.window?.addSubview(tempImageView)
        tempImageView.contentMode = .scaleAspectFit
        
        self.dismiss(animated: false, completion: nil)
        
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveLinear) {
            tempImageView.frame = targetTemp
        } completion: { (finished:Bool) in
            tempImageView.removeFromSuperview()
        }
    }
    
    func saveImageSheet(image:UIImage) {
        let actionSheet = DPSheetView.sheet(title: nil, cancelTitle: "取消", itemTitles: ["保存至相册"]) { (index, title) in
            self.saveImage(image: image)
        } cancelBlock: {
        }
        actionSheet.show()
    }
    
    func saveImage(image:UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error == nil {
            let alert = UIAlertController(title: "提示", message: "图片已保存至相册", preferredStyle: UIAlertController.Style.alert)
            let btnOK = UIAlertAction(title: "好的", style: .default, handler: nil)
            alert.addAction(btnOK)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}
