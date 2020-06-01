//
//  JHTabBarController.swift
//  JHTabBarController
//
//  Created by iOS on 2020/5/28.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit

public class JHTabBarController: UITabBarController {

    /// vc数组
    public override var viewControllers: [UIViewController]? {
        didSet {
            initializeContainers()
        }
    }

    /// 选中VC
    public override var selectedViewController: UIViewController? {
        willSet {
            guard let vc = newValue,
                let index = viewControllers?.firstIndex(of: vc) else { return }
            handleSelection(index: index)
        }
    }
    
    /// item上的容器view数组
    private(set) var containers: [UIView] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        initializeContainers()
    }
 
    /// 横竖屏切换监听刷新frame
    /// - Parameters:
    ///   - size:
    ///   - coordinator:
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { [weak self] (transitionCoordinatorContext) -> Void in
            self?.layoutContainers()
        }, completion: { (transitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    // MARK: 创建自定义视图
    /// 添加视图容器
    private func initializeContainers() {
        containers.forEach { $0.removeFromSuperview() }
        containers.removeAll()
        
        guard let items = tabBar.items else { return }
        guard items.count <= 5 else { fatalError("More button not supported") }
        
        for index in 0 ..< items.count {
            let viewContainer = UIView()
            viewContainer.isExclusiveTouch = true
            viewContainer.tag = index
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(itemTap))
            viewContainer.addGestureRecognizer(tapGesture)
            tabBar.addSubview(viewContainer)
            containers.append(viewContainer)
        }
                
        if !containers.isEmpty {
            createCustomIcons(containers: containers)
        }
        
        layoutContainers()
    }
    
    /// 设置自定义item的frame
    private func layoutContainers() {

        let itemWidth = tabBar.bounds.width / CGFloat(containers.count)
        
        var itemHeight = 49
        switch UIApplication.shared.statusBarOrientation {
        case .portrait, .portraitUpsideDown:
            itemHeight = 49
        default:
            itemHeight = IS_IOS11() && IS_Little() ? 32 : 49
        }
        
        let isRTL = tabBar.userInterfaceLayoutDirection == .rightToLeft
        
        for (index, container) in containers.enumerated() {
            let i = isRTL ? (containers.count - 1 - index) : index
            let frame = CGRect(x: itemWidth * CGFloat(i), y: 0, width: itemWidth, height: CGFloat(itemHeight))
            container.frame = frame
            
            if let item = tabBar.items?.at(index) as? JHTabBarItem {
                item.contentView?.frame = container.bounds
                item.contentView?.layoutSubviews()
            }
        }
    }
    
    /// 初始化自定义视图
    /// - Parameter containers: 容器视图数组
    private func createCustomIcons(containers: [UIView]) {
        guard let items = tabBar.items as? [JHTabBarItem] else {
            fatalError("items must inherit JHTabBarItem")
        }

        for (index, item) in items.enumerated() {
            let container = containers[index]
            
            guard let vi = item.contentView else {
                return
            }
            container.addSubview(vi)

            vi.renderingMode = item.renderingMode ? .alwaysTemplate : .alwaysOriginal
            vi.image = item.image
            vi.selectedImage = item.selectedImage
            vi.iconColor = item.iconColor
            vi.highlightIconColor = item.selectedIconColor
            
            vi.title = item.title
            vi.textColor = item.textColor
            vi.highlightTextColor = item.selectedTextColor
            vi.textFontSize = item.textFontSize
            vi.lottieName = item.lottieName
            
            if 0 == index { // selected first elemet
                vi.select()
            } else {
                vi.deselect()
            }
            item.image = nil
            item.title = ""
        }
    }
    
    // MARK: 添加点击事件
    @objc private func itemTap(gesture: UITapGestureRecognizer) {
        guard let index = gesture.view?.tag else { return }
        handleSelection(index: index)
    }
    
    private func handleSelection(index: Int) {
        guard let items = tabBar.items as? [JHTabBarItem] else { return }
        let currentIndex = index

        if items[currentIndex].isEnabled == false { return }

        let controller = children[currentIndex]

        if let shouldSelect = delegate?.tabBarController?(self, shouldSelect: controller)
            , !shouldSelect {
            return
        }

        if selectedIndex != currentIndex {
            let previousItem = items.at(selectedIndex)
            previousItem?.contentView?.deselect()

            let currentItem: JHTabBarItem = items[currentIndex]
            currentItem.contentView?.select()

            selectedIndex = index
        } else {
            if let navVC = viewControllers?[selectedIndex] as? UINavigationController {
                navVC.popToRootViewController(animated: true)
            }
        }
        delegate?.tabBarController?(self, didSelect: controller)
    }
}


extension JHTabBarController {
    private func IS_IOS11() -> Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 11.0 }
    
    private func IS_Little() -> Bool { return UIScreen.main.bounds.height < 400 }
    /**
     Selected UITabBarItem with animaton

     - parameter from: Index for unselected animation
     - parameter to:   Index for selected animation
     */
    public func setSelectIndex(from: Int, to: Int) {
        selectedIndex = to
        guard let items = tabBar.items as? [JHTabBarItem] else {
            fatalError("items must inherit JHTabBarItem")
        }

        let previousItem =  items[from]
        previousItem.contentView?.deselect()

        let currentItem: JHTabBarItem = items[to]
        currentItem.contentView?.select()

    }
}

extension UIView {
    var userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        return UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute)
    }
}

extension Collection where Self.Index == Self.Indices.Iterator.Element {
    /**
     Returns an optional element. If the `index` does not exist in the collection, the subscript returns nil.

     - parameter safe: The index of the element to return, if it exists.

     - returns: An optional element from the collection at the specified index.
     */
    public subscript(safe i: Index) -> Self.Iterator.Element? {
        return at(i)
    }

    /**
     Returns an optional element. If the `index` does not exist in the collection, the function returns nil.

     - parameter index: The index of the element to return, if it exists.

     - returns: An optional element from the collection at the specified index.
     */
    public func at(_ i: Index) -> Self.Iterator.Element? {
        return indices.contains(i) ? self[i] : nil
    }
}
