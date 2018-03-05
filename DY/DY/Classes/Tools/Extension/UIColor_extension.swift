//
//  UIColor_extension.swift
//  DY
//
//  Created by David.G on 2018/3/3.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit

extension UIColor {
    
    //MARK: 便利构造器
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    convenience init(hex:Int) {
        self.init(hex: hex, alpha: 1.0)
    }
    
    convenience init(hex:Int, alpha:CGFloat) {
        let red = CGFloat(((hex & 0xFF0000) >> 16))/255.0
        let green = CGFloat(((hex & 0xFF00) >> 8))/255.0
        let blue = CGFloat((hex & 0xFF))/255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    //MARK: 类型方法
    class func randomColor() -> UIColor{
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)), a: 1.0)
    }
}
