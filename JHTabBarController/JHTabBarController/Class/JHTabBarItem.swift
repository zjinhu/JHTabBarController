//
//  JHTabBarItem.swift
//  JHTabBarController
//
//  Created by iOS on 2020/5/28.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit

class JHTabBarItem: UITabBarItem {

    @IBInspectable open var lottieName: String?

    open var contentView: JHTabBarItemContentView?
//    /// The font used to render the UITabBarItem text.
    @IBInspectable open var textFontSize: CGFloat = 10
    /// The color of the UITabBarItem text.
    @IBInspectable open var textColor: UIColor = #colorLiteral(red: 0.5079551811, green: 0.5472556715, blue: 0.6011400746, alpha: 1)
    @IBInspectable open var selectedTextColor: UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)

    /// The tint color of the UITabBarItem icon.
    @IBInspectable open var renderingMode: Bool = false
    
    @IBInspectable open var iconColor: UIColor = #colorLiteral(red: 0.5079551811, green: 0.5472556715, blue: 0.6011400746, alpha: 1)
    @IBInspectable open var selectedIconColor: UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)

    open var bgDefaultColor: UIColor = UIColor.clear // background color
    open var bgSelectedColor: UIColor = UIColor.clear
    
    
    public init(_ contentView: JHTabBarItemContentView = JHTabBarItemContentView()) {
        super.init()
        self.contentView = contentView
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.contentView = JHTabBarItemContentView()
    }

}
