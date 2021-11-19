//
//  JHTabBarController.swift
//  JHTabBarController
//
//  Created by iOS on 2020/5/28.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit

public class JHTabBarController: UITabBarController {
    //滑动手势
    private var panGesture = UIPanGestureRecognizer()
    //转场动画
    private let transitionUtil = TransitionUtil()
    //获得vc数量
    private var vcCount: Int {
        guard let vcs = viewControllers else { return 0 }
        return vcs.count
    }
    
    
    /// 点击回调返回点击第几个
    public typealias DidSelectHandler = ((_ index: Int) -> Void)
    /// tabbar属性,可修改
    public var jhTabBar = JHTabBar()

    fileprivate var didSelectHandler: DidSelectHandler?
    /// 选中VC
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
    /// 选中第几个
    public override var selectedIndex: Int {
        willSet {
            guard let tabBar = tabBar as? JHTabBar else {
                return
            }
            tabBar.select(itemAt: selectedIndex, animated: false)
        }
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
    
    @available(iOS 13.0, *)
    lazy var tabBarAppear: UITabBarAppearance = {
        let appear =  UITabBarAppearance()
        return appear
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setValue(jhTabBar, forKey: "tabBar")
        
        
        //添加交互手势
        delegate = transitionUtil
        panGesture.addTarget(self, action: #selector(panHandle(_:)))
        view.addGestureRecognizer(panGesture)
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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

    /// 隐藏分隔线
    public func hideTopLine(){
        if #available(iOS 13.0, *) {
            tabBarAppear.shadowImage = UIImage()
            tabBarAppear.backgroundImage = UIImage()
            tabBarAppear.configureWithTransparentBackground()
            tabBar.standardAppearance = tabBarAppear
        } else {
            tabBar.shadowImage = UIImage()
            tabBar.backgroundImage = UIImage()
        }
    }
    ///设置tabbar背景颜色
    public func setTabbarBackColor(_ color: UIColor = .white){
        jhTabBar.imageView.backgroundColor = color
    }
    ///设置tabbar背景图片
    public func setTabbarBackImage(_ image: UIImage?){
        jhTabBar.imageView.image = image
    }
}

extension JHTabBarController{
    
    @objc func panHandle(_ pan: UIPanGestureRecognizer) {
        let translationX = panGesture.translation(in: view).x
        let absX = abs(translationX)
        let progress = absX / view.frame.width
        
        switch panGesture.state {
        case .began:
            transitionUtil.interactive = true
            //速度
            let velocityX = panGesture.velocity(in: view).x
            if velocityX < 0 {
                if selectedIndex < vcCount - 1 {
                    selectedIndex += 1
                }
            }else {
                if selectedIndex > 0 {
                    selectedIndex -= 1
                }
            }
        case .changed:
            //更新转场进度，进度数值范围为0.0~1.0。
            transitionUtil.interactionTransition.update(progress)
        case .cancelled, .ended:
            if progress > 0.25 {
                //.finish()方法被调用后，转场动画从当前的状态将继续进行直到动画结束，转场完成
                transitionUtil.interactionTransition.finish()
            }else {
                //.cancel()被调用后，转场动画从当前的状态回拨到初始状态，转场取消。
                transitionUtil.interactionTransition.cancel()
            }
            //无论转场的结果如何，恢复为非交互状态。
            transitionUtil.interactive = false
        default:
            break
        }
    }
}

enum TabBarOperationDirection {
    case left
    case right
}

class TransitionUtil: NSObject {
    var transitionType: TabBarOperationDirection?
    //交互转场
    var interactive = false
    let interactionTransition = UIPercentDrivenInteractiveTransition()
}

extension TransitionUtil: UIViewControllerAnimatedTransitioning {
    //控制转场动画执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    //执行动画的地方，最核心的方法。
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        transitionAnimation(transitionContext: transitionContext)
    }
    
    //如果实现了，会在转场动画结束后调用，可以执行一些收尾工作。
    func animationEnded(_ transitionCompleted: Bool) {
        
    }
    
    private func transitionAnimation(transitionContext: UIViewControllerContextTransitioning) {
        //获得容器视图（转场动画发生的地方）
        let containerView = transitionContext.containerView
        //动画执行时间
        let duration = transitionDuration(using: transitionContext)
        
        //fromVC (即将消失的视图)
        let fromVC = transitionContext.viewController(forKey: .from)!
        let fromView = fromVC.view!
        //toVC (即将出现的视图)
        let toVC = transitionContext.viewController(forKey: .to)!
        let toView = toVC.view!
        var offset = containerView.frame.width
        offset = transitionType == .left ? offset : -offset
        
        let fromTransform =  CGAffineTransform(translationX: offset, y: 0)
        let toTransform = CGAffineTransform(translationX: -offset, y: 0)
        
        containerView.addSubview(toView)
        
        toView.transform = toTransform
        UIView.animate(withDuration: duration, animations: {
            fromView.transform = fromTransform
            toView.transform = .identity
        }) { (finished) in
            fromView.transform = .identity
            toView.transform = .identity
            //考虑到转场中途可能取消的情况，转场结束后，恢复视图状态。(通知是否完成转场)
            let wasCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!wasCancelled)
        }
    }
}

extension TransitionUtil: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let fromIndex = tabBarController.viewControllers?.firstIndex(of: fromVC) ?? 0
        let toIndex = tabBarController.viewControllers?.firstIndex(of: toVC) ?? 0
        transitionType = fromIndex < toIndex ? .right : .left
        return self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? interactionTransition : nil
    }
}
