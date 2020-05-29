//
//  JHTabBarItemContentView.swift
//  JHTabBarController
//
//  Created by iOS on 2020/5/29.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import SnapKit
#if canImport(Lottie)
import Lottie
#endif
public enum JHTabBarItemContentMode : Int {
    
    case alwaysOriginal // Always set the original image size
    
    case alwaysTemplate // Always set the image as a template image size
}
open class JHTabBarItemContentView: UIView {

    /// 设置contentView的偏移
    open var insets = UIEdgeInsets.zero
    
    /// 是否被选中
    open var selected = false


    /// 文字颜色
    open var textColor = UIColor(white: 0.57254902, alpha: 1.0) {
        didSet {
            if !selected { titleLabel.textColor = textColor }
        }
    }
    
    /// 高亮时文字颜色
    open var highlightTextColor = UIColor(red: 0.0, green: 0.47843137, blue: 1.0, alpha: 1.0) {
        didSet {
            if selected { titleLabel.textColor = highlightIconColor }
        }
    }
    
    /// icon颜色
    open var iconColor = UIColor(white: 0.57254902, alpha: 1.0) {
        didSet {
            if !selected { imageView.tintColor = iconColor }
        }
    }
    
    /// 高亮时icon颜色
    open var highlightIconColor = UIColor(red: 0.0, green: 0.47843137, blue: 1.0, alpha: 1.0) {
        didSet {
            if selected { imageView.tintColor = highlightIconColor }
        }
    }
    
    /// 背景颜色
    open var backColor = UIColor.clear {
        didSet {
            if !selected { backgroundColor = backColor }
        }
    }
    
    /// 高亮时背景颜色
    open var highlightBackColor = UIColor.clear {
        didSet {
            if selected { backgroundColor = highlightBackColor }
        }
    }
    
    open var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    open var lottieName: String? {
        didSet {
            #if canImport(Lottie)
            guard let str = lottieName, str.count > 0 else {
                return
            }
            let animation = Animation.named(str)
            lottieView.animation = animation
            #endif
        }
    }
    
    /// Icon imageView renderingMode, default is .alwaysTemplate like UITabBarItem
    open var renderingMode: UIImage.RenderingMode = .alwaysTemplate {
        didSet {
            self.updateDisplay()
        }
    }

    /// Item content mode, default is .alwaysTemplate like UITabBarItem
    open var itemContentMode: JHTabBarItemContentMode = .alwaysTemplate {
        didSet {
            self.updateDisplay()
        }
    }

    /// Icon imageView's image
    open var image: UIImage? {
        didSet {
            if !selected { self.updateDisplay() }
        }
    }

    open var selectedImage: UIImage? {
        didSet {
            if selected { self.updateDisplay() }
        }
    }
    
    open var textFontSize: CGFloat = UIScreen.main.scale == 3.0 ? 13.0 : 12.0
    
    open var imageView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    open var titleLabel: UILabel = {
        let titleLabel = UILabel.init()
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .clear
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    #if canImport(Lottie)
    let lottieView: AnimationView = {
        let lottieView = AnimationView()
        lottieView.contentMode = .scaleAspectFit
        return lottieView
    }()
    #endif

    // MARK: -
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = false
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        #if canImport(Lottie)
        addSubview(lottieView)
        #endif

        titleLabel.textColor = textColor
        imageView.tintColor = iconColor
        backgroundColor = backColor
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let s: CGFloat = UIScreen.main.scale == 3.0 ? 24.0 : 20.0
        titleLabel.font = .systemFont(ofSize: textFontSize)
        
        if let t = title, t.count > 0, image != nil, let l = lottieName, l.count > 0{
            imageView.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.snp.centerY).offset(4)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(s)
            }
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(imageView.snp.bottom).offset(3)
                make.centerX.equalToSuperview()
            }
            #if canImport(Lottie)
            imageView.isHidden = true
            lottieView.snp.makeConstraints { (make) in
                make.edges.equalTo(imageView)
            }
            #endif
        }else if let t = title, t.count > 0, image != nil{
            imageView.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.snp.centerY).offset(4)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(s)
            }
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(imageView.snp.bottom).offset(3)
                make.centerX.equalToSuperview()
            }
        }else if let l = lottieName, l.count > 0, let t = title, t.count > 0{
            #if canImport(Lottie)
            titleLabel.font = .systemFont(ofSize: textFontSize)
            lottieView.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.snp.centerY).offset(4)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(s)
            }
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(lottieView.snp.bottom).offset(3)
                make.centerX.equalToSuperview()
            }
            #else
            titleLabel.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
            #endif
        }else if let l = lottieName, l.count > 0, image != nil{
            #if canImport(Lottie)
            lottieView.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.height.equalTo(30)
            }
            #else
            imageView.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.height.equalTo(30)
            }
            #endif
        }else if let l = lottieName, l.count > 0{
            #if canImport(Lottie)
            lottieView.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.height.equalTo(30)
            }
            #endif
        }else if image != nil{
            imageView.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.height.equalTo(30)
            }
        }else if let t = title, t.count > 0{
            titleLabel.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
        }

    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func updateDisplay() {
        imageView.image = (selected ? (selectedImage ?? image) : image)?.withRenderingMode(renderingMode)
        imageView.tintColor = selected ? highlightIconColor : iconColor
        titleLabel.textColor = selected ? highlightTextColor : textColor
        backgroundColor = selected ? highlightBackColor : backColor
    }

    // MARK: - INTERNAL METHODS
    func select(animated: Bool = true) {
        selected = true
        updateDisplay()
        #if canImport(Lottie)
        lottieView.play()
        #endif
    }

    func deselect(animated: Bool = true) {
        selected = false
        updateDisplay()
        #if canImport(Lottie)
        lottieView.stop()
        #endif
    }


}
