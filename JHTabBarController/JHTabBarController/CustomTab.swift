//
//  CustomTab.swift
//  JHTabBarController
//
//  Created by iOS on 2020/8/31.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit

class CustomTab: JHTabBarItemContentView {

    var unSelectColor = UIColor.clear

    var selectColor = UIColor.red
        
    var bgView: UIView = {
        let vi = UIView.init()
        vi.layer.cornerRadius = 20
        vi.clipsToBounds = true
        vi.isUserInteractionEnabled = false
        return vi
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(imageView)
        #if canImport(Lottie)
        bgView.addSubview(lottieView)
        #endif
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.snp.makeConstraints { (m) in
            m.centerX.centerY.equalToSuperview()
            m.height.equalTo(40)
        }

        imageView.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        #if canImport(Lottie)
        lottieView.snp.remakeConstraints { (make) in
            make.edges.equalTo(imageView)
        }
        #endif

        titleLabel.snp.remakeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.left.equalTo(imageView.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
    }

    override func updateDisplay() {
        imageView.image = (isSelected ? (selectedImage ?? image) : image)?.withRenderingMode(renderingMode)
        imageView.tintColor = isSelected ? highlightIconColor : iconColor
        titleLabel.textColor = isSelected ? highlightTextColor : textColor
        bgView.backgroundColor = isSelected ? selectColor : unSelectColor
    }
}
