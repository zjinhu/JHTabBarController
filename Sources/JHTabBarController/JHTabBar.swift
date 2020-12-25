//
//  JHTabBar.swift
//  JHTabBarController
//
//  Created by iOS on 2020/6/2.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import SnapKit
public class JHTabBar: UITabBar {
    
    private var buttons: [JHTabBarButton] = []
    
    private var itemFrames = [CGRect]()
    private var tabBarItems = [UIView]()
    
//    private lazy var indicator: UIView = {
//        let circle = UIView(frame: .zero)
//        circle.backgroundColor = tintColor
//        addSubview(circle)
//        return circle
//    }()
    
    public override var selectedItem: UITabBarItem? {
        willSet {
            guard let newValue = newValue else {
                buttons.forEach { (item) in
                    item.select(false)
                }
                return
            }
            guard let index = items?.firstIndex(of: newValue),
                  index != NSNotFound else {
                return
            }
            select(itemAt: index, animated: false)
//            animate(index: index)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    var container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private func configure() {
        ///12.0 12.1 tabbar偏移修复,系统bug
        //        if #available(iOS 12.2, *) {
        //
        //        } else {
        //            isTranslucent = false
        //        }
        addSubview(container)
        let bottomOffset: CGFloat
        if #available(iOS 11.0, *) {
            bottomOffset = safeAreaInsets.bottom
        } else {
            bottomOffset = 0
        }
        container.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-bottomOffset)
        }
    }
    
    override public func safeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.safeAreaInsetsDidChange()
            container.snp.updateConstraints { (make) in
                make.bottom.equalToSuperview().offset(-safeAreaInsets.bottom)
            }
        } else { }
    }
    
    public override var items: [UITabBarItem]? {
        didSet {
            reloadViews()
        }
    }
    
    public override func setItems(_ items: [UITabBarItem]?, animated: Bool) {
        super.setItems(items, animated: animated)
        reloadViews()
    }
    
    func reloadViews() {
        subviews.forEach { (view) in
            if String(describing: type(of: view)) == "UITabBarButton" {
                view.removeFromSuperview()
            }
        }
        
        buttons.forEach { (bar) in
            bar.removeFromSuperview()
        }
        
        buttons = items?.map({ (item) -> JHTabBarButton in
            return self.button(forItem: item)
        }) ?? []
        
        var lastButton : JHTabBarButton?
        let itemWidth = (bounds.width - 20) / CGFloat(buttons.count)
        buttons.forEach { (button) in
            self.container.addSubview(button)
            button.snp.remakeConstraints { (make) in
                make.top.bottom.equalToSuperview()
                make.width.equalTo(itemWidth)
                if let last = lastButton{
                    make.left.equalTo(last.snp.right)
                }else{
                    make.left.equalToSuperview()
                }
            }
            lastButton = button
        }
        
        layoutIfNeeded()
    }
    
    private func button(forItem item: UITabBarItem) -> JHTabBarButton {
        let button = JHTabBarButton(item: item)
        button.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        if selectedItem != nil && item === selectedItem {
            button.select()
        }
        return button
    }
    
    @objc private func btnPressed(sender: JHTabBarButton) {
        guard let index = buttons.firstIndex(of: sender),
              index != NSNotFound,
              let item = items?[index] else {
            return
        }
        buttons.forEach { (button) in
            guard button != sender else {
                return
            }
            button.deselect()
        }
        sender.select()
        
        delegate?.tabBar?(self, didSelect: item)
    }
    
    func select(itemAt index: Int, animated: Bool = false) {
        guard index < buttons.count else {
            return
        }
        let selectedbutton = buttons[index]
        buttons.forEach { (button) in
            guard button != selectedbutton else {
                return
            }
            button.deselect(animated: false)
        }
        selectedbutton.select(animated: false)
    }
    
//    private func animate(index: Int) {
//
//        guard index < buttons.count else {
//            return
//        }
//        let selectedbutton = buttons[index]
//
//        indicator.snp.remakeConstraints { (make) in
//            make.centerX.bottom.equalTo(selectedbutton)
//            make.width.height.equalTo(4)
//        }
//
//        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
//            self.layoutIfNeeded()
//        }
//
//        animator.startAnimation()
//    }
}
