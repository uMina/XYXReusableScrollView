//
//  XYXReusableScrollView.swift
//  XYXReusableScrollViewDemo
//
//  Created by Teresa on 2018/7/19.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

protocol XYXSkimViewDataSource {
    func numberOfPages(in skimView: XYXSkimView) -> Int
    func skimView(_ skimView: XYXSkimView, cellForPageAt pageIndex: Int) -> UIView
}
protocol XYXSkimViewDelegate {
    func skimViewDidScroll(_ skimView:XYXSkimView,offsetX:CGFloat)
}


class XYXSkimView: UIView {
    
    var delegate:XYXSkimViewDelegate?
    var dataSource:XYXSkimViewDataSource?{
        didSet{
            reloadData()
        }
    }
    
    var currentPageIndex:Int = 0{
        didSet{
            configuePage(at: currentPageIndex)
        }
    }

    fileprivate let scrollView = UIScrollView()
    fileprivate var visibleViews:[XYXSkimViewVisibleCellModel] = []
    fileprivate var reusedViews:[XYXSkimViewReusableCellModel] = []
    
    override var frame: CGRect{
        didSet{
            scrollView.frame = bounds
        }
    }
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseSetting()
        reloadData()
    }
    
    func baseSetting() {
        scrollView.frame = frame
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false
        addSubview(scrollView)
        configuePage(at: currentPageIndex)
    }
    
    //MARK: - Reuse Method
    open func register(_ nib: UINib?, forCellReuseIdentifier identifier: String){
        if let cellView = nib?.instantiate(withOwner: nil, options: nil).first as? UIView{
            let cellModel = XYXSkimViewReusableCellModel(view: cellView, reuseIdentifier: identifier)
            let isIncluded = reusedViews.contains { (model) -> Bool in
                return model.reuseIdentifier == identifier
            }
            if isIncluded == false{
                reusedViews.append(cellModel)
            }
        }
    }
    
    open func register(_ cellClass: Swift.AnyClass, forCellReuseIdentifier identifier: String){
        if cellClass is UIView.Type {
            let cellView = (cellClass as! UIView.Type).init()
            let cellModel = XYXSkimViewReusableCellModel(view: cellView, reuseIdentifier: identifier)
            let isIncluded = reusedViews.contains { (model) -> Bool in
                return model.reuseIdentifier == identifier
            }
            if isIncluded == false{
                reusedViews.append(cellModel)
            }
        }
    }
    
    open func dequeueReusableCell(withIdentifier identifier: String) -> UIView?{
        let view = reusedViews.filter { (model) -> Bool in
            return model.reuseIdentifier == identifier
        }.first?.view
        return view
    }
    
    //MARK: -
    func reloadData() {
        let pageCount = CGFloat(dataSource?.numberOfPages(in: self) ?? 0)
        scrollView.contentSize = CGSize(width: scrollView.frame.width * pageCount, height: scrollView.frame.height)
        configuePage(at: currentPageIndex)
    }
    
    func configuePage(at pageIndex:Int) {
        let pageView = dataSource?.skimView(self, cellForPageAt: pageIndex)
        var pageFrame = scrollView.bounds
        pageFrame.origin.x = pageFrame.width * CGFloat(pageIndex)
        pageView?.frame = pageFrame
        if let pv = pageView {
            print("添加页面到scrollView,位置:\(NSStringFromCGRect(pageFrame))")
            scrollView.addSubview(pv)
            let cellModel = XYXSkimViewVisibleCellModel(view: pv, index: pageIndex)
            visibleViews.append(cellModel)
        }
    }
}
extension XYXSkimView:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.skimViewDidScroll(self, offsetX: scrollView.contentOffset.x)
        
        // 索引器
        let pageCount = dataSource?.numberOfPages(in: self) ?? 0
        let cellWidth = scrollView.frame.width
        
        var firstIndex = Int(floor(scrollView.bounds.minX/cellWidth))
        var lastIndex =  Int(floor(scrollView.bounds.maxX/cellWidth))
        firstIndex = max(firstIndex, 0)
        lastIndex = min(lastIndex, pageCount-1)
        
        print("firstIndex = \(firstIndex), lastIndex = \(lastIndex)")
        
        // 回收不需要显示的
        visibleViews = visibleViews.filter({ (model) -> Bool in
            return model.index >= firstIndex && model.index <= lastIndex
        })
        let reduceVisibleViews = visibleViews.filter({ (model) -> Bool in
            return model.index < firstIndex || model.index > lastIndex
        })
        for reduceItem in reduceVisibleViews {
            print("被移除的view.index = \(reduceItem.index)")
            reduceItem.view.removeFromSuperview()
        }

        // 显示需要显示的
        for idx in firstIndex...lastIndex{
            var cellDidShow = false
            for item in visibleViews{
                if item.index == idx{
                    print("已经显示,index = \(idx)")
                    cellDidShow = true
                }
            }
            if cellDidShow == false{
                print("准备显示,index = \(idx)")
                configuePage(at: idx)
            }
        }
        
    }
}
