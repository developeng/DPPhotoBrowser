//
//  GlobalConfigDefinition.swift
//  CFStreamingVideo
//
//  Created by chenfeng on 2019/8/21.
//  Copyright © 2019 chenfeng. All rights reserved.
//

import Foundation
import UIKit

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height

let IS_IPHONE_X = STATUSBAR_HEIGHT > 20 ? true : false

let STATUS_AND_NAV_BAR_HEIGHT:CGFloat = IS_IPHONE_X == true ? 88.0 : 64.0
let NAVBAR_HEIGHT:CGFloat = IS_IPHONE_X == true ? 44.0 : 20.0
let TABBAR_HEIGHT:CGFloat = IS_IPHONE_X == true ? 83.0 : 49.0
let BOTTOM_SAFE_HEIGHT:CGFloat = IS_IPHONE_X == true ? 34 : 0

//为防止以后更换
func Auto(_ AT: CGFloat) -> CGFloat {
    return AT.auto()
}
func AutoFont(_ Font: CGFloat) -> CGFloat {
    return Font.auto()
}
/*
 * 颜色
 */

let ThemeBlueColor = RGB(r: 47.0, g: 166.0, b: 252.0, a: 1.0)//蓝色
let ThemeYellowColor = RGB(r: 234.0, g: 185.0, b: 120.0, a: 1.0)//黄色
let ThemeGrayWhiteColor = RGB(r: 203.0, g: 204.0, b: 206.0, a: 1.0)//灰白
let ThemeBlackColor = RGB(r: 29.0, g: 32.0, b: 41.0, a: 1.0)//黑色


//数据
typealias JSONDictionary = [String: Any]

