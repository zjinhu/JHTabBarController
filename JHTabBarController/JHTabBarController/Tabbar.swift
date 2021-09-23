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
        
        let item1 = UITabBarItem()
        item1.image = UIImage.init(named: "tab_chat_nor")
        item1.selectedImage = UIImage.init(named: "tab_chat_hi")
        item1.title = "123"
        v1.tabBarItem = item1
        
        let v2 = ViewController()
        
        let item2 = UITabBarItem()
        item2.image = UIImage.init(named: "tab_home_nor")
        item2.selectedImage = UIImage.init(named: "tab_home_hi")
        item2.iconColor = .red
        item2.selectedIconColor = .green
        item2.title = "123"
        item2.titleColor = .black
        item2.selectedTitleColor = .green
        v2.tabBarItem = item2
        
        let v3 = ViewController()
        
        let item3 = UITabBarItem()
//        item3.image = UIImage(named: "tab_mine_nor")
//        item3.selectedImage = UIImage.init(named: "tab_mine_hi")
        item3.lottieName = "03"
//        item3.titleColor = .red
//        item3.selectedTitleColor = .green
        item3.title = "123"
        v3.tabBarItem = item3
        
        let nav1 = UINavigationController.init(rootViewController: v1)
        let nav2 = UINavigationController.init(rootViewController: v2)
        let nav3 = UINavigationController.init(rootViewController: v3)
        
        let tab = JHTabBarController()
//        tab.hideTopLine()
        tab.setTabbarBackColor(.yellow)
//        tab.setTabbarBackImage(UIImage(named: "bg_Image"))
        tab.viewControllers = [nav1,nav2,nav3] 
        tab.selectedIndex = 2
        tab.didSelect { (inx) in
            print("\(inx)")
        }
        return tab
    }
}
