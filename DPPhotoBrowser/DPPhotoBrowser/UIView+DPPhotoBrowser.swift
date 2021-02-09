//
//  UIView+DPPhotoBrowser.swift
//  DPPhotoBrowser
//
//  Created by developeng on 2021/2/5.
//

import Foundation
import UIKit

extension UIView {
    func getParsentView(view:UIView) -> UIView {
        if (view.next is UIViewController)  {
            return view;
        }
        return self.getParsentView(view: view.superview!)
    }
}
