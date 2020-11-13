//
//  ViewController.swift
//  JHTabBarController
//
//  Created by iOS on 2020/5/28.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import SwiftBrick
import SwiftMediator
import SwiftShow
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.random
        tabBarItem.badgeValue = "9"
        
        UIButton.snpButton(supView: view, backColor: .orange, title: "123") { (_) in
//            let vc = PViewController()
//            SwiftMediator.shared.present(vc, needNav: true, modelStyle: 0)
            
//            let vc = PViewController()
//            var component = PresentedViewComponent(contentSize: CGSize(width: ScreenWidth, height: 300))
//            component.destination = .bottomBaseline
//            component.presentTransitionType = .translation(origin: .bottomOutOfLine)
//            vc.presentedViewComponent = component
//            self.presentViewController(vc)
            
            SwiftMediator.shared.push("PViewController")
        } snapKitMaker: { (m) in
            m.center.equalToSuperview()
            m.width.height.equalTo(100)
        }

    }


}

