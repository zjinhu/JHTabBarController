//
//  SceneDelegate.swift
//  JHTabBarController
//
//  Created by iOS on 2020/5/28.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
//        let v1 = ViewController()
//        let item1 = JHTabBarItem()
//        item1.image = UIImage.init(named: "tab_chat_nor")
//        item1.selectedImage = UIImage.init(named: "tab_chat_hi")
//        item1.title = "123"
//        v1.tabBarItem = item1
//        let v2 = ViewController()
//        let item2 = JHTabBarItem()
//        item2.image = UIImage.init(named: "tab_home_nor")
//        item2.selectedImage = UIImage.init(named: "tab_home_hi")
//        v2.tabBarItem = item2
//        let v3 = ViewController()
//        let item3 = JHTabBarItem()
//        item3.image = UIImage.init(named: "tab_mine_nor")
//        item3.selectedImage = UIImage.init(named: "tab_mine_hi")
//        item3.lottieName = "03"
//        v3.tabBarItem = item3
//        let nav1 = UINavigationController.init(rootViewController: v1)
//        let nav2 = UINavigationController.init(rootViewController: v2)
//        let nav3 = UINavigationController.init(rootViewController: v3)
//        
//        let tab = JHTabBarController()
//        
//        tab.viewControllers = [nav1,nav2,nav3]
//        tab.setSelectIndex(from: 0, to: 2)
//        
//        let windowScene = scene as! UIWindowScene
//        window? = UIWindow.init(windowScene: windowScene)
//        window?.frame = windowScene.coordinateSpace.bounds
//        window?.makeKeyAndVisible()
//        window?.rootViewController = tab
//        window?.backgroundColor = .white
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

