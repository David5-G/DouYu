//
//  RecommendViewController.swift
//  DY
//
//  Created by david on 2018/3/20.
//  Copyright © 2018年 david. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kHeaderViewH: CGFloat = 50
private let kItemW = (kScreenW - 3*kItemMargin) / 2
private let kNormalItemH = kItemW * 3/4
private let kBeautyItemH = kItemW * 4/3

private let kNormalCellId = "normalCellId"
private let kBeautyCellId = "beautyCellId"
private let kHeaderViewId = "headerViewId"

class RecommendViewController: UIViewController {

    //MARK:- 懒加载
    lazy var collectionView: UICollectionView = {
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //2.创建collectionView
        print(view.bounds)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.backgroundColor = UIColor(hex: 0xFFFFFF, alpha: 1.0)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(UINib(nibName: "CollectionViewBeautyCell", bundle: nil), forCellWithReuseIdentifier: kBeautyCellId)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewId)
        
        
        //3.返回
        return collectionView
    }()
    
    //MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置UI
        setupUI()
    }
}


//MARK:- 设置UI
extension RecommendViewController {
    private func setupUI() {
        view.addSubview(collectionView)
    }
}



//MARK:- UICollectionViewDataSource
extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            return collectionView.dequeueReusableCell(withReuseIdentifier: kBeautyCellId, for: indexPath)
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewId, for: indexPath)
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kBeautyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}












