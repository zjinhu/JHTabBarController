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

         let windowScene = scene as! UIWindowScene
         window? = UIWindow.init(windowScene: windowScene)
         window?.frame = windowScene.coordinateSpace.bounds
         window?.makeKeyAndVisible()
         window?.rootViewController = Tabbar.creatTabbar()
         window?.backgroundColor = .white

        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

