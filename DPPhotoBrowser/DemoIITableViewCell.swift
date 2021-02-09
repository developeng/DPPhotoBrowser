//
//  DemoIITableViewCell.swift
//  DPPhotoBrowser
//
//  Created by developeng on 2021/2/5.
//

import UIKit

class DemoIITableViewCell: UITableViewCell {
    
    var imgArr:Array<Any>?
    
    
    lazy var collectionView: UICollectionView = {
        let flowLayout:UICollectionViewFlowLayout  = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .vertical
        
        let collectionView:UICollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: DP_SCREEN_WIDTH, height: 250), collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        addSubview(self.collectionView)
        self.collectionView.register(DemoPhotoBrowserCell.classForCoder(), forCellWithReuseIdentifier: "DemoPhotoBrowserCell")
        
    }
}

extension DemoIITableViewCell: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imgArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:DemoPhotoBrowserCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DemoPhotoBrowserCell", for: indexPath) as! DemoPhotoBrowserCell
        let item = self.imgArr?[indexPath.item]
        if item is UIImage {
            cell.imageV.image = item as? UIImage
        } else {
            if (item is String) && ((item as! String).contains("http")) {
                
                let url = URL(string: item as! String)
                cell.imageV.kf.setImage(with: url)
            } else {
                cell.imageV.image = UIImage(named: item as! String)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let buttonW:CGFloat = (self.frame.width - 10.0 * 3.0)/3.0
        return CGSize(width: buttonW, height: buttonW)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DPPhotoBrowser.showPhotos(imgArr: self.imgArr!,superView: self.collectionView,selectIndex: indexPath.item)

    }
}


class DemoPhotoBrowserCell: UICollectionViewCell {
        
    lazy var imageV:UIImageView = {
        let imageView:UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.imageV)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        self.imageV.frame = self.bounds
    }
}


