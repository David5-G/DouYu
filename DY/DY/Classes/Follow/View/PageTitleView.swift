//
//  PageTitleView.swift
//  DY
//
//  Created by david on 2018/2/28.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    //MARK:- 定义属性
    private var titles: [String]
    
    //MARK:- 

    //MARK:  自定义构造函数， 必须实现init？（coder...函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
