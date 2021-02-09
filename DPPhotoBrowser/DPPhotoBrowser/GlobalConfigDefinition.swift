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

let DP_SCREEN_WIDTH = UIScreen.main.bounds.size.width
let DP_SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let DP_STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height

let DP_IS_IPHONE_X = DP_STATUSBAR_HEIGHT > 20 ? true : false

let DP_STATUS_AND_NAV_BAR_HEIGHT:CGFloat = DP_IS_IPHONE_X == true ? 88.0 : 64.0
let DP_NAVBAR_HEIGHT:CGFloat = DP_IS_IPHONE_X == true ? 44.0 : 20.0
let DP_TABBAR_HEIGHT:CGFloat = DP_IS_IPHONE_X == true ? 83.0 : 49.0
let DP_BOTTOM_SAFE_HEIGHT:CGFloat = DP_IS_IPHONE_X == true ? 34 : 0
