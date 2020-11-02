//
//  JHTabBarItem.swift
//  JHTabBarController
//
//  Created by iOS on 2020/5/28.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit

fileprivate var KLottieName: Int = 0x2020_11_01
fileprivate var kTitleFont: Int = 0x2020_11_02
fileprivate var kTitleColor: Int = 0x2020_11_03
fileprivate var kTitleSelectedColor: Int = 0x2020_11_04
fileprivate var kIconColor: Int = 0x2020_11_05
fileprivate var kIconSelectedColor: Int = 0x2020_11_06
fileprivate var kRenderingMode: Int = 0x2020_11_09

extension UITabBarItem {

    @IBInspectable public var lottieName: String? {
        get {
            return objc_getAssociatedObject(self, &KLottieName) as? String
        }
        set {
            objc_setAssociatedObject(self, &KLottieName, newValue, .OBJC_ASSOCIATION_RETAIN)
            image = UIImage()
        }
    }

    @IBInspectable public var titleColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &kTitleColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &kTitleColor, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    @IBInspectable public var selectedTitleColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &kTitleSelectedColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &kTitleSelectedColor, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    @IBInspectable public var iconColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &kIconColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &kIconColor, newValue, .OBJC_ASSOCIATION_RETAIN)
            renderingMode = true
        }
    }

    @IBInspectable public var selectedIconColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &kIconSelectedColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &kIconSelectedColor, newValue, .OBJC_ASSOCIATION_RETAIN)
            renderingMode = true
        }
    }

    public var titleFontSize: CGFloat? {
        get {
            return objc_getAssociatedObject(self, &kTitleFont) as? CGFloat
        }
        set {
            objc_setAssociatedObject(self, &kTitleFont, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }

    public var renderingMode: Bool? {
        get {
            return objc_getAssociatedObject(self, &kRenderingMode) as? Bool
        }
        set {
            objc_setAssociatedObject(self, &kRenderingMode, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
