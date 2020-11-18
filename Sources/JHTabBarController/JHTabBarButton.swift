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
public enum JHTabBarButtonMode : Int {
    
    case alwaysOriginal // Always set the original image size
    
    case alwaysTemplate // Always set the image as a template image size
}
open class JHTabBarButton: UIControl {

    /// 设置contentView的偏移
    open var insets = UIEdgeInsets.zero

    /// 文字颜色
    open var textColor : UIColor?{
        didSet {
            if !isSelected { titleLabel.textColor = textColor }
        }
    }
    
    /// 高亮时文字颜色
    open var highlightTextColor : UIColor?{
        didSet {
            if isSelected { titleLabel.textColor = highlightIconColor }
        }
    }
    
    /// icon颜色
    open var iconColor : UIColor?{
        didSet {
            if !isSelected { imageView.tintColor = iconColor }
        }
    }
    
    /// 高亮时icon颜色
    open var highlightIconColor : UIColor?{
        didSet {
            if isSelected { imageView.tintColor = highlightIconColor }
        }
    }

    open var title: String? {
        didSet {
            titleLabel.text = title
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
            updateDisplay()
        }
    }

    /// Item content mode, default is .alwaysTemplate like UITabBarItem
    open var itemContentMode: JHTabBarButtonMode = .alwaysTemplate {
        didSet {
            updateDisplay()
        }
    }

    /// Icon imageView's image
    open var image: UIImage? {
        didSet {
            if !isSelected { updateDisplay() }
        }
    }

    open var selectedImage: UIImage? {
        didSet {
            if isSelected { updateDisplay() }
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
    open var lottieView: AnimationView = {
        let lottieView = AnimationView()
        lottieView.contentMode = .scaleAspectFit
        lottieView.isUserInteractionEnabled = false
        return lottieView
    }()
    #endif

    public init(item: UITabBarItem) {
        super.init(frame: .zero)
        configureSubviews()
        defer {
            self.item = item
        }
    }

    var item: UITabBarItem? {
        didSet {
            image = item?.image
            selectedImage = item?.selectedImage
            title = item?.title

            renderingMode = item?.imageRenderingMode ?? false ? .alwaysTemplate : .alwaysOriginal

            iconColor = item?.iconColor
            highlightIconColor = item?.selectedIconColor

            textColor = item?.titleColor
            highlightTextColor = item?.selectedTitleColor
            
            if let font = item?.titleFontSize  {
                textFontSize = font
            }
            
            #if canImport(Lottie)
            if let name = item?.lottieName {
                lottieName = name
            }
            
            if let speed = item?.lottieAnimationSpeed {
                lottieView.animationSpeed = speed
            }
            #endif
        }
    }
    
    private func configureSubviews() {
        addSubview(imageView)
        addSubview(titleLabel)
        
        #if canImport(Lottie)
        addSubview(lottieView)
        #endif

        titleLabel.textColor = textColor
        imageView.tintColor = iconColor
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        
        var iconSize = 24
        var isLandscape = false
        switch UIApplication.shared.statusBarOrientation {
        case .portrait, .portraitUpsideDown:
            iconSize = 24
            isLandscape = false
        default:
            iconSize = 20
            isLandscape = true
        }

        titleLabel.font = .systemFont(ofSize: textFontSize)
        
        if let t = title, t.count > 0, image != nil, let l = lottieName, l.count > 0{
            imageView.snp.remakeConstraints { (make) in
                if isLandscape {
                    make.centerX.centerY.equalToSuperview()
                    make.width.height.equalTo(iconSize)
                }else{
                    make.bottom.equalTo(self.snp.centerY).offset(4)
                    make.centerX.equalToSuperview()
                    make.width.height.equalTo(iconSize)
                }
            }
            titleLabel.snp.remakeConstraints { (make) in
                if isLandscape {
                    make.left.equalTo(imageView.snp.right).offset(4)
                    make.centerY.equalToSuperview()
                }else{
                    make.top.equalTo(imageView.snp.bottom).offset(3)
                    make.centerX.equalToSuperview()
                }
            }
            #if canImport(Lottie)
            imageView.isHidden = true
            lottieView.snp.remakeConstraints { (make) in
                make.edges.equalTo(imageView)
            }
            #endif
        }else if let t = title, t.count > 0, image != nil{
            imageView.snp.remakeConstraints { (make) in
                if isLandscape {
                    make.centerX.centerY.equalToSuperview()
                    make.width.height.equalTo(iconSize)
                }else{
                    make.bottom.equalTo(self.snp.centerY).offset(4)
                    make.centerX.equalToSuperview()
                    make.width.height.equalTo(iconSize)
                }
            }
            titleLabel.snp.remakeConstraints { (make) in
                if isLandscape {
                    make.left.equalTo(imageView.snp.right).offset(4)
                    make.centerY.equalToSuperview()
                }else{
                    make.top.equalTo(imageView.snp.bottom).offset(3)
                    make.centerX.equalToSuperview()
                }
            }
        }else if let l = lottieName, l.count > 0, let t = title, t.count > 0{
            #if canImport(Lottie)
            titleLabel.font = .systemFont(ofSize: textFontSize)
            lottieView.snp.remakeConstraints { (make) in
                if isLandscape {
                    make.centerX.centerY.equalToSuperview()
                    make.width.height.equalTo(iconSize)
                }else{
                    make.bottom.equalTo(self.snp.centerY).offset(4)
                    make.centerX.equalToSuperview()
                    make.width.height.equalTo(iconSize)
                }
            }
            titleLabel.snp.remakeConstraints { (make) in
                if isLandscape {
                    make.left.equalTo(imageView.snp.right).offset(4)
                    make.centerY.equalToSuperview()
                }else{
                    make.top.equalTo(imageView.snp.bottom).offset(3)
                    make.centerX.equalToSuperview()
                }
            }
            #else
            titleLabel.snp.remakeConstraints { (make) in
                make.center.equalToSuperview()
            }
            #endif
        }else if let l = lottieName, l.count > 0, image != nil{
            #if canImport(Lottie)
            lottieView.snp.remakeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.height.equalTo(28)
            }
            #else
            imageView.snp.remakeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.height.equalTo(28)
            }
            #endif
        }else if let l = lottieName, l.count > 0{
            #if canImport(Lottie)
            lottieView.snp.remakeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.height.equalTo(28)
            }
            #endif
        }else if image != nil{
            imageView.snp.remakeConstraints { (make) in
                make.center.equalToSuperview()
                make.width.height.equalTo(28)
            }
        }else if let t = title, t.count > 0{
            titleLabel.snp.remakeConstraints { (make) in
                make.center.equalToSuperview()
            }
        }

    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func updateDisplay() {
        imageView.image = (isSelected ? (selectedImage ?? image) : image)?.withRenderingMode(renderingMode)
        imageView.tintColor = isSelected ? highlightIconColor : iconColor
        titleLabel.textColor = isSelected ? highlightTextColor : textColor
    }

    // MARK: - INTERNAL METHODS
    open func select(animated: Bool = true) {
        isSelected = true
        updateDisplay()
        #if canImport(Lottie)
        lottieView.play()
        #endif
    }

    open func deselect(animated: Bool = true) {
        isSelected = false
        updateDisplay()
        #if canImport(Lottie)
        lottieView.stop()
        #endif
    }
}
