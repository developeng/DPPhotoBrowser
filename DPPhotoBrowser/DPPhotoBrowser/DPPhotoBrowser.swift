//
//  DPPhotoBrowser.swift
//  DPPhotoBrowser
//
//  Created by developeng on 2021/2/4.
//

import UIKit

class DPPhotoBrowser: NSObject {
    /// 查看大图
    /// - Parameters:
    ///   - imgArr: 图片数组,支持网络图片，本地图片，UIImage,例如["https://...jpg"],["lizi.png"],[UIImage]
    ///   - selectIndex: 首次点开 选中图片的下标记
    static func showPhotos(imgArr:Array<Any>, superView:UIView,selectIndex:Int = 0, config: DPPhotoBrowerConfig = DPPhotoBrowerConfig()) {
        
        let vc:DPPhotoBrowserController = DPPhotoBrowserController()
        vc.sourceImagesContainerView = superView
        vc.config = config
        vc.currentPage = selectIndex
        vc.countImage = imgArr.count
        vc.imgArr = imgArr
        vc.show()
        vc.scrollToItem(index: (selectIndex ))
    }
}
