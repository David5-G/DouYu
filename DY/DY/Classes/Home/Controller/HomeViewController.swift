//
//  HomeViewController.swift
//  DY
//
//  Created by david on 2018/2/27.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit
//MARK:- 常量
private let kPageTitleViewH: CGFloat = 40

//MARK:-
class HomeViewController: UIViewController {
    
    //MARK:  属性
    
    //MARK:  懒加载属性
    private lazy var pageTitleView: PageTitleView = { [weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: 40)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let pageTitleView = PageTitleView(frame: titleFrame, titles: titles)
        pageTitleView.delegate = self
        return pageTitleView
    }()
    
    private lazy var pageContentView: PageContentView = { [weak self] in
        
        //1.确定内容的frame
        let contentH = kScrrenH - kStatusBarH - kNavigationBarH - kPageTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kPageTitleViewH, width: kScreenW, height: contentH)
        
        //2.确定自控制器
        var childVCs = [UIViewController]()
        
        for index in 0...3{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVCs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentVC: self)
        contentView.delegate = self
        return contentView
    }()
}


//MARK:- 生命周期
extension HomeViewController {
    
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
        
        //3.添加pageContentView
        view.addSubview(pageContentView)
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


// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController: PageTitleViewDelegate {
    
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}


// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController: PageContentViewDelegate {
    
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}



