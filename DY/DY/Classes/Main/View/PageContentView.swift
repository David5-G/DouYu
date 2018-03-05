//
//  PageContentView.swift
//  DY
//
//  Created by David.G on 2018/3/3.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit

//MARK:- 常量
private let kContentCellID = "ContentCellID"

//MARK:- 协议
protocol PageContentViewDelegate: class {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}


//MARK:-
class PageContentView: UIView {

    //MARK: 属性
    private var childVCs: [UIViewController]
    private weak var parentVC: UIViewController?
    private var startOffsetX: CGFloat = 0
    private var isForbidScrollDelegate = false
    weak var delegate: PageContentViewDelegate?
    

    //MARK: 懒加载属性
    private lazy var collectionView: UICollectionView = { [weak self] in
       //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        return collectionView
    }()
    
    
    //MARK: 自定义构造函数
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController?) { 
        self.childVCs = childVCs
        self.parentVC = parentVC
        
        super.init(frame: frame)

        //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 设置UI
extension PageContentView {
    
    private func setupUI() {
        //1.添加子控制器
        for childVC in childVCs {
            parentVC?.addChildViewController(childVC)
        }
        //2.添加collectionView,用cell存放childVC
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
    
}

//MARK:- 遵守UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        //2.给cell设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = childVCs[(indexPath.item)]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        //3.return
        return cell
    }
}

//MARK:-
extension PageContentView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //0.过滤 点击titleLabel造成的偏移
        if isForbidScrollDelegate { return }
        
        //1.参数
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        //2.判断左右滑动
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { //左滑
            //1) 计算progress
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            //2) 计算index
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex+1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            //3)如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else { //右滑
            //1) 计算progress
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            //2.计算index
            targetIndex = Int(currentOffsetX/scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        
        //3.将参数传给titleView
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}



//MARK:- 外部方法
extension PageContentView {
    func setCurrentIndex(_ currentIndex: Int) {
        
        // 1.记录需要进制执行代理方法
        isForbidScrollDelegate = true
        
        
        
        /* //方法一: 用scrollToItem方法
        let indexPath = NSIndexPath(item: currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
        */
        
        //方法二:
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX, y:0), animated: false)
    }
    
}
















