//
//  JHTabBarItem.swift
//  JHTabBarController
//
//  Created by iOS on 2020/5/28.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit

public class JHTabBarItem: UITabBarItem {

    @IBInspectable public var lottieName: String?

    open var contentView: JHTabBarItemContentView?
//    /// The font used to render the UITabBarItem text.
    @IBInspectable public var textFontSize: CGFloat = 10
    /// The color of the UITabBarItem text.
    @IBInspectable public var textColor: UIColor = #colorLiteral(red: 0.5079551811, green: 0.5472556715, blue: 0.6011400746, alpha: 1)
    @IBInspectable public var selectedTextColor: UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)

    /// The tint color of the UITabBarItem icon.
    @IBInspectable public var renderingMode: Bool = false
    
    @IBInspectable public var iconColor: UIColor = #colorLiteral(red: 0.5079551811, green: 0.5472556715, blue: 0.6011400746, alpha: 1)
    @IBInspectable public var selectedIconColor: UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)

    public var bgDefaultColor: UIColor = UIColor.clear // background color
    public var bgSelectedColor: UIColor = UIColor.clear
    
    /// The current badge value
    @IBInspectable public override var badgeValue: String? {
        get {
            return contentView?.badgeValue
        }
        set(newValue) {
            contentView?.badgeValue = newValue
        }
    }
    
    @IBInspectable public override var badgeColor: UIColor? {
        didSet {
            if let _ = badgeColor {
                contentView?.badgeColor = badgeColor
            }
        }
    }
    
    public init(_ contentView: JHTabBarItemContentView = JHTabBarItemContentView()) {
        super.init()
        self.contentView = contentView
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentView = JHTabBarItemContentView()
    }
    
    func configContentView() {
        contentView?.renderingMode = renderingMode ? .alwaysTemplate : .alwaysOriginal
        contentView?.image = image
        contentView?.selectedImage = selectedImage
        contentView?.iconColor = iconColor
        contentView?.highlightIconColor = selectedIconColor
        
        contentView?.title = title
        contentView?.textColor = textColor
        contentView?.highlightTextColor = selectedTextColor
        contentView?.textFontSize = textFontSize
        contentView?.lottieName = lottieName
        contentView?.layoutSubviews()
    }

}
