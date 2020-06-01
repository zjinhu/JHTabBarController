//
//  Tabbar.swift
//  JHTabBarController
//
//  Created by iOS on 2020/6/1.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit

class Tabbar {
    static func creatTabbar() -> JHTabBarController{
        let v1 = ViewController()
        let item1 = JHTabBarItem()
        item1.image = UIImage.init(named: "tab_chat_nor")
        item1.selectedImage = UIImage.init(named: "tab_chat_hi")
        item1.title = "123"
        v1.tabBarItem = item1
        let v2 = ViewController()
        let item2 = JHTabBarItem()
        item2.image = UIImage.init(named: "tab_home_nor")
        item2.selectedImage = UIImage.init(named: "tab_home_hi")
        v2.tabBarItem = item2
        let v3 = ViewController()
        let item3 = JHTabBarItem()
        item3.image = UIImage.init(named: "tab_mine_nor")
        item3.selectedImage = UIImage.init(named: "tab_mine_hi")
        item3.lottieName = "03"
        v3.tabBarItem = item3
        let nav1 = UINavigationController.init(rootViewController: v1)
        let nav2 = UINavigationController.init(rootViewController: v2)
        let nav3 = UINavigationController.init(rootViewController: v3)
        
        let tab = JHTabBarController()
        
        tab.viewControllers = [nav1,nav2,nav3]
        tab.setSelectIndex(from: 0, to: 2)
        return tab
    }
}
