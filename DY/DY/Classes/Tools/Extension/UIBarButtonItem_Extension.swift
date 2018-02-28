//
//  UIBarButtonItem_Extension.swift
//  DY
//
//  Created by david on 2018/2/28.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    //方法一:类方法
    class func createItem(imgName: String, highImgName: String, size: CGSize) -> UIBarButtonItem {
        
        let btn = UIButton()
        btn.setImage(UIImage(named: imgName ), for: .normal)
        btn.setImage(UIImage(named: highImgName), for: .highlighted)
        btn.frame = CGRect(origin: .zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    
    
    
    //方法二: 便利构造函数
    //1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imgName: String, highImgName: String = "", size: CGSize = .zero) {
        
        //1.创建btn
        let btn = UIButton()
        //2.设置图片
        btn.setImage(UIImage(named: imgName ), for: .normal)
        if !highImgName.isEmpty {
            btn.setImage(UIImage(named: highImgName), for: .highlighted)
        }
        //3.设置尺寸
        if size == .zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin: .zero, size: size)
        }
        
        //4.调用init创建item
        self.init(customView: btn)
    }
}
