//
//  DPPhotoBrowser.swift
//  DPPhotoBrowser
//
//  Created by developeng on 2021/2/4.
//

import UIKit

let DP_SCREEN_WIDTH = UIScreen.main.bounds.size.width
let DP_SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let DP_STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height

let DP_IS_IPHONE_X = DP_STATUSBAR_HEIGHT > 20 ? true : false

let DP_STATUS_AND_NAV_BAR_HEIGHT:CGFloat = DP_IS_IPHONE_X == true ? 88.0 : 64.0
let DP_NAVBAR_HEIGHT:CGFloat = DP_IS_IPHONE_X == true ? 44.0 : 20.0
let DP_TABBAR_HEIGHT:CGFloat = DP_IS_IPHONE_X == true ? 83.0 : 49.0
let DP_BOTTOM_SAFE_HEIGHT:CGFloat = DP_IS_IPHONE_X == true ? 34 : 0

class DPPhotoBrowser: NSObject {
    /// 查看大图
    /// - Parameters:
    ///   - imgArr: 图片数组,支持网络图片，本地图片，UIImage,例如["https://...jpg"],["lizi.png"],[UIImage]
    ///   - selectIndex: 首次点开 选中图片的下标记
    public static func showPhotos(imgArr:Array<Any>, superView:UIView,selectIndex:Int = 0, config: DPPhotoBrowerConfig = DPPhotoBrowerConfig()) {
        
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
