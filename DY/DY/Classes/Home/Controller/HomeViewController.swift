//
//  HomeViewController.swift
//  DY
//
//  Created by david on 2018/2/27.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit
//MARK:-自定义常量
private let kPageTitleViewH: CGFloat = 40

//MARK:-
class HomeViewController: UIViewController {

    //MARK:-  懒加载属性
   private lazy var pageTitleView: PageTitleView = {
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: 40)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let pageTitleView = PageTitleView(frame: titleFrame, titles: titles)
        return pageTitleView
    }()
    
    //MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI
        setupUI()
    }
}

//MARK:- 设置UI
extension HomeViewController {
    
    private func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置naviBar
        setupNavigationBar()
        
        //2.添加pageTitleView
        view.addSubview(pageTitleView)
    }
    
    private func setupNavigationBar (){
        //1.leftItem
        navigationItem.leftBarButtonItem = UIBarButtonItem(imgName: "logo", highImgName: "", size: .zero)
        
        //2.rightItem
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imgName: "image_my_history", highImgName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imgName: "btn_search", highImgName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imgName: "Image_scan", highImgName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
    
}








