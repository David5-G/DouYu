//
//  MainTabBarViewController.swift
//  DY
//
//  Created by david on 2018/2/27.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc(name: "Home")
        addChildVc(name: "Live")
        addChildVc(name: "Follow")
        addChildVc(name: "Profile")
        
    }

    private func addChildVc(name:String){
        //1.通过storyboard获取控制器
        let childVc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVc)
    }
}
