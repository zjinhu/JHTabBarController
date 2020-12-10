//
//  JHTabBarController.swift
//  JHTabBarController
//
//  Created by iOS on 2020/5/28.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit


public class JHTabBarController: UITabBarController {
    public typealias DidSelectHandler = ((_ index: Int) -> Void)

    public var jhTabBar = JHTabBar()

    fileprivate var didSelectHandler: DidSelectHandler?
    
    public override var selectedViewController: UIViewController? {
        willSet {
            guard let newValue = newValue else {
                return
            }
            guard let tabBar = tabBar as? JHTabBar, let index = viewControllers?.firstIndex(of: newValue) else {
                return
            }
            tabBar.select(itemAt: index, animated: false)
        }
    }

    public override var selectedIndex: Int {
        willSet {
            guard let tabBar = tabBar as? JHTabBar else {
                return
            }
            tabBar.select(itemAt: selectedIndex, animated: false)
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setValue(jhTabBar, forKey: "tabBar")
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private var _barHeight: CGFloat = 49
    public var barHeight: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return _barHeight + view.safeAreaInsets.bottom
            } else {
                return _barHeight
            }
        }
        set {
            _barHeight = newValue
            updateTabBarFrame()
        }
    }

    private func updateTabBarFrame() {
        var tabFrame = tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = view.frame.size.height - barHeight
        tabBar.frame = tabFrame
    }

    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTabBarFrame()
    }

    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateTabBarFrame()
        jhTabBar.reloadViews()
    }
    
    public override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
        }
        updateTabBarFrame()
    }

    public override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.firstIndex(of: item) else {
            return
        }
        if let controller = viewControllers?[idx] {
            selectedIndex = idx
            delegate?.tabBarController?(self, didSelect: controller)
            didSelectHandler?(idx)
        }
    }
    
    public func didSelect(_ block: DidSelectHandler?){
        didSelectHandler = block
    }
    
    public func hideTopLine(){
        if #available(iOS 13.0, *) {
            let appear =  UITabBarAppearance()
            appear.shadowImage = UIImage()
            appear.backgroundImage = UIImage()
            appear.configureWithTransparentBackground()
            tabBar.standardAppearance = appear
        } else {
            tabBar.shadowImage = UIImage()
            tabBar.backgroundImage = UIImage()
        }
    }
}
