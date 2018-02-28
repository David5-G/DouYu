//
//  HomeViewController.swift
//  DY
//
//  Created by david on 2018/2/27.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI
        setupUI()
    }
}

extension HomeViewController {
    private func setupUI() {
        //1.设置naviBar
        setupNavigationBar()
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








