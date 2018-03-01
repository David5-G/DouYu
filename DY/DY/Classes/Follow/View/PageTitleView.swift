//
//  PageTitleView.swift
//  DY
//
//  Created by david on 2018/2/28.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit

//MARK:- 常量
private let kScrollLineH: CGFloat = 2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85.0/255.0, 85.0/255.0, 85.0/255.0)
private let kSelectColor: (CGFloat, CGFloat, CGFloat) = (1.0, 128.0/255.0, 0)

//MARK:-
class PageTitleView: UIView {
    //MARK: 属性
    private var titles: [String]
    
    
    //MARK: 懒加载属性
    //存titles的数组
    private lazy var titleLabels: [UILabel] = [UILabel]()
    
    //scrollView
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    //滚动条
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    //MARK: 自定义构造函数
    //自定义构造函数, 必须实现init？（coder...函数
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 配置UI
extension PageTitleView {
    private func setupUI() {
        //1.添加scrollView
        scrollView.frame = bounds
        addSubview(scrollView)
        
        //① label
        setupTitleLabels()
        
        //② 滑块
        setupSrollLine()
        
        //2.底线
        setupBottomLine()
    }
    
    /** 设置底线 */
    private func setupBottomLine(){
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
    }
    
    /** scrollView的subview - label */
    private func setupTitleLabels() {
        //1.共用尺寸
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //1.创建UILabel
            let label = UILabel()
            
            //2.设置
            label.text = title
            
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.2, alpha: 1)
            label.textAlignment = .center
            //3.设置frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.给label添加手势
            //label.isUserInteractionEnabled = true
            //let tapGr = UITapGestureRecognizer(target: self, action: nil)
            
        }
    }
    
    /** scrollView的subview - 滚动线 */
    private func setupSrollLine() {
        
        guard let firstLabel = titleLabels.first else { return }
        
        firstLabel.textColor = UIColor(red: kSelectColor.0, green: kSelectColor.1, blue: kSelectColor.2, alpha: 1)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        scrollView.addSubview(scrollLine)
    }
}




















