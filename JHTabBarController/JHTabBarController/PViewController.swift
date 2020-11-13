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
        // Do any additional setup after loading the view.
        addDefaultBackBarButton()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
