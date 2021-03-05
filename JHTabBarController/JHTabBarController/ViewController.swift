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
        
        UIButton.snpButton(supView: view, backColor: .orange, title: "点击跳转页面") { (_) in
            SwiftMediator.shared.push("PViewController")
        } snapKitMaker: { (m) in
            m.center.equalToSuperview()
            m.width.height.equalTo(100)
        }

    }


}

