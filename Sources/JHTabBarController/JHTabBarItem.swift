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
fileprivate var KLottieSpeed: Int = 0x2020_11_10
extension UITabBarItem {
    
    ///lottie动画文件名称,可不添加后最
    @IBInspectable public var lottieName: String? {
        get {
            return objc_getAssociatedObject(self, &KLottieName) as? String
        }
        set {
            objc_setAssociatedObject(self, &KLottieName, newValue, .OBJC_ASSOCIATION_RETAIN)
            image = UIImage()
        }
    }
    ///lottie动画执行速度
    public var lottieAnimationSpeed: CGFloat? {
        get {
            return objc_getAssociatedObject(self, &KLottieSpeed) as? CGFloat
        }
        set {
            objc_setAssociatedObject(self, &KLottieSpeed, newValue, .OBJC_ASSOCIATION_RETAIN)
            image = UIImage()
        }
    }
    ///方便XIB修改动画执行速度
    @IBInspectable public var lottieSpeed: CGFloat {
        set {
            lottieAnimationSpeed = newValue
        }
        get {
            return lottieAnimationSpeed ?? 1.0
        }
    }
    ///未选中字体颜色
    @IBInspectable public var titleColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &kTitleColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &kTitleColor, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    ///选中字体颜色
    @IBInspectable public var selectedTitleColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &kTitleSelectedColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &kTitleSelectedColor, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    ///未选中图片颜色(图片imageRenderingMode=true模式下可用)
    @IBInspectable public var iconColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &kIconColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &kIconColor, newValue, .OBJC_ASSOCIATION_RETAIN)
            renderingMode = true
        }
    }
    ///选中图片颜色(图片imageRenderingMode=true模式下可用)
    @IBInspectable public var selectedIconColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &kIconSelectedColor) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &kIconSelectedColor, newValue, .OBJC_ASSOCIATION_RETAIN)
            renderingMode = true
        }
    }
    ///字体大小
    public var titleFontSize: CGFloat? {
        get {
            return objc_getAssociatedObject(self, &kTitleFont) as? CGFloat
        }
        set {
            objc_setAssociatedObject(self, &kTitleFont, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    ///XIB修改字体大小
    @IBInspectable public var fontSize: CGFloat {
        set {
            titleFontSize = newValue
        }
        get {
            return titleFontSize ?? 14.0
        }
    }
    
    ///图片模式---是否通透
    public var imageRenderingMode: Bool? {
        get {
            return objc_getAssociatedObject(self, &kRenderingMode) as? Bool
        }
        set {
            objc_setAssociatedObject(self, &kRenderingMode, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    ///XIB修改图片模式
    @IBInspectable public var renderingMode: Bool {
        set {
            imageRenderingMode = newValue
        }
        get {
            return imageRenderingMode ?? false
        }
    }
}
