//
//  DPPhotoBrowerConfig.swift
//  DPPhotoBrowser
//
//  Created by developeng on 2021/2/8.
//

import UIKit

class DPPhotoBrowerConfig: NSObject {
    //最大放大比例
    var maxScale:CGFloat = 2.0
    //最小缩小比例
    var minScale:CGFloat = 0.8
    //是否隐藏头部指示器
    var isHiddenTitle:Bool = false
    //是否隐藏底部指示器
    var isHiddenPageControl:Bool = false
    //是否去除保存图片至相册功能
    var isSaveImg:Bool = true
}
