//
//  PViewController.swift
//  JHTabBarController
//
//  Created by iOS on 2020/11/13.
//  Copyright © 2020 iOS. All rights reserved.
//

import SwiftBrick
import SwiftShow
class PViewController: JHViewController , PresentedViewType {
    var presentedViewComponent: PresentedViewComponent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addDefaultBackBarButton()
    }

}
