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
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)


//MARK:- 协议
protocol PageTitleViewDelegate: class {
    //加上class限定为 只能由类来遵守协议
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int)
}


//MARK:-
class PageTitleView: UIView {
    //MARK: 属性
    private var currentIndex: Int = 0
    private var titles: [String]
    weak var delegate: PageTitleViewDelegate?
    
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, a: 1)
            label.textAlignment = .center
            //3.设置frame
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            //5.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGr = UITapGestureRecognizer(target: self, action: #selector(titleLabelClicked(_:)))
            label.addGestureRecognizer(tapGr)
            
        }
    }
    
    /** scrollView的subview - 滚动线 */
    private func setupSrollLine() {
        
        guard let firstLabel = titleLabels.first else { return }
        
        firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2, a: 1)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        scrollView.addSubview(scrollLine)
    }
}

//MARK:- 监听label的点击
extension PageTitleView {
    
    @objc private func titleLabelClicked(_ tapGr: UITapGestureRecognizer) {
        //1.获取当前的label
        guard let currentLabel = tapGr.view as? UILabel else { return }
        
        //2.如果重复点击同一个title, 直接返回
        if currentLabel.tag  == currentIndex { return }
        
        //3.获取之前的label
        let preLabel = titleLabels[currentIndex]
        
        //4.切换字体颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2, a: 1.0)
        preLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, a: 1.0)
        
        //5.保存最新label的下标值
        currentIndex = currentLabel.tag
        
        //6.共东条位置发生变化
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //7.通知代理执行代理方法
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
        
    }
}

//MARK:- 对外暴露的方法
extension PageTitleView {
    
    func setTitleWithProgress(_ progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //1.获取label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.label字体颜色渐变
        //1) 获取变化范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        //2) 变化
        sourceLabel.textColor = UIColor(r: (kSelectColor.0 - colorDelta.0) * progress, g: (kSelectColor.1 - colorDelta.1) * progress, b: (kSelectColor.2 - colorDelta.2) * progress, a: 1.0)
        targetLabel.textColor = UIColor(r: (kNormalColor.0 + colorDelta.0) * progress, g: (kNormalColor.1 + colorDelta.1) * progress, b: (kNormalColor.2 + colorDelta.2) * progress, a: 1.0)
        
        //4.记录最新的index
        currentIndex = targetIndex
    }
}
















