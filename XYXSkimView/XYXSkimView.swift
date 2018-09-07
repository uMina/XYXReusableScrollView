//
//  XYXReusableScrollView.swift
//  XYXReusableScrollViewDemo
//
//  Created by Teresa on 2018/7/19.
//  Copyright © 2018年 Teresa. All rights reserved.
//
//  横屏、可复用的滑动视图

import UIKit

@objc public protocol XYXSkimViewDataSource {
    func numberOfPages(in skimView: XYXSkimView) -> Int
    func skimView(_ skimView: XYXSkimView, cellForRowAt index: Int) -> XYXSkimViewCell
}
public protocol XYXSkimViewDelegate {
    func skimViewDidScroll(_ skimView:XYXSkimView,offsetX:CGFloat)
}


open class XYXSkimView: UIView {
    
    open var delegate:XYXSkimViewDelegate?
    open var dataSource:XYXSkimViewDataSource?{
        didSet{
            configureScrollView()
        }
    }
    
    open var currentPageIndex:Int = 0{
        didSet{
            configueCell(at: currentPageIndex)
        }
    }

    open var pagingEnabled = true{
        didSet{
            scrollView.isPagingEnabled = pagingEnabled
        }
    }
    
    fileprivate let scrollView = UIScrollView()
    fileprivate var visibleViews:[XYXSkimViewCell] = []
    fileprivate var reusedViews:[XYXSkimViewCell] = []
    fileprivate let defaultCellWidth:CGFloat = UIScreen.main.bounds.width
    
    open override var bounds: CGRect{
        didSet{
            configureScrollView()
        }
    }
    
    //MARK: - Life Cycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        baseSetting()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        baseSetting()
    }
    
    fileprivate func baseSetting() {
        addSubview(scrollView)
        scrollView.isPagingEnabled = pagingEnabled
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.bounces = false
    }
    
    //MARK: - Reuse Method
    open func register(_ nib: UINib?, forCellReuseIdentifier identifier: String){
        if let cell = nib?.instantiate(withOwner: nil, options: nil).first as? XYXSkimViewCell{
            let isIncluded = reusedViews.contains { (view) -> Bool in
                return view.reuseIdentifier == identifier
            }
            if isIncluded == false{
                reusedViews.append(cell)
            }
        }
    }
    
    open func register(_ cellClass: XYXSkimViewCell.Type, forCellReuseIdentifier identifier: String){
        let cell = cellClass.init(reuseIdentifier: identifier)
        let isIncluded = reusedViews.contains { (view) -> Bool in
            return view.reuseIdentifier == identifier
        }
        if isIncluded == false{
            reusedViews.append(cell)
        }
    }
    
    open func dequeueReusableCell(withIdentifier identifier: String) -> UIView?{
        if let index = reusedViews.index(where: { (model) -> Bool in
            return model.reuseIdentifier == identifier
        }){
            let model = reusedViews[index]
            return model
        }
        return nil
    }
    
    //MARK: - Refresh UI
    ///更新重构内容页并刷新页面数据
    open func reloadData() {
        //更新contentView的宽度
        let cellCount = CGFloat(dataSource?.numberOfPages(in: self) ?? 0)
        scrollView.contentSize = CGSize(width: scrollView.frame.width * cellCount, height: scrollView.frame.height)
        
        //删除所有的可见cell
        for item in scrollView.subviews {
            item.removeFromSuperview()
        }
        for item in visibleViews {
            let isContains = reusedViews.contains(where: { (model) -> Bool in
                return item.reuseIdentifier == model.reuseIdentifier
            })
            if isContains == false{
                reusedViews.append(item)
            }
        }
        visibleViews.removeAll()
        //刷新
        justReloadData()
    }
    ///刷新当前页面数据
    open func justReloadData() {
        configueCell(at: currentPageIndex)
    }
    
    //MARK: - 滚动到指定的页面
    ///滚动到某页并刷新
    open func scrollTo(page:Int, animated:Bool = false){
        let newX = frame.width * CGFloat(page)
        let newRect = CGRect(x: newX, y: bounds.minY, width: bounds.width, height: bounds.height)
        scrollView.scrollRectToVisible(newRect, animated: animated)
        currentPageIndex = page
        justReloadData()
    }
}

extension XYXSkimView:UIScrollViewDelegate{
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.skimViewDidScroll(self, offsetX: scrollView.contentOffset.x)
        
        // 索引器
        let cellCount = dataSource?.numberOfPages(in: self) ?? 0
        let cellWidth = defaultCellWidth
        
        var firstIndex = Int(floor(scrollView.bounds.minX/cellWidth))
        var lastIndex =  Int(floor(scrollView.bounds.maxX/cellWidth))
        firstIndex = max(firstIndex, 0)
        lastIndex = min(lastIndex, cellCount-1)

        // 回收不需要显示的
        let reduceVisibleViewModels = visibleViews.filter({ (model) -> Bool in
            return model.tag < firstIndex || model.tag > lastIndex
        })
        visibleViews = visibleViews.filter({ (model) -> Bool in
            return model.tag >= firstIndex && model.tag <= lastIndex
        })

        for reduceItem in reduceVisibleViewModels {
            reusedViews.append(reduceItem)
            reduceItem.removeFromSuperview()
        }

        // 显示需要显示的
        for idx in firstIndex...lastIndex{
            var cellDidShow = false
            for item in visibleViews{
                if item.tag == idx{
                    cellDidShow = true
                }
            }
            if cellDidShow == false{
                configueCell(at: idx)
            }
        }

    }
}

//MARK: - Private
extension XYXSkimView{
    
    private func configureScrollView() {
        for item in scrollView.subviews{
            item.removeFromSuperview()
        }
        for item in visibleViews {
            let isContains = reusedViews.contains(where: { (model) -> Bool in
                return item.reuseIdentifier == model.reuseIdentifier
            })
            if isContains == false{
                reusedViews.append(item)
            }
        }
        visibleViews.removeAll()
        
        scrollView.frame = bounds
        let cellCount = dataSource?.numberOfPages(in: self) ?? 0
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(cellCount), height: scrollView.frame.height)
        
        guard cellCount > currentPageIndex else {
            return
        }
        configueCell(at: currentPageIndex)
    }
    
    private func configueCell(at cellIndex:Int) {
        if let skimCell = dataSource?.skimView(self, cellForRowAt: cellIndex) {
            
            //复用池的处理
            if let index = reusedViews.index(where: { (cell) -> Bool in
                return cell == skimCell
            }){
                reusedViews.remove(at: index)
            }
            visibleViews.append(skimCell)
            
            //UI处理
            var newFrame = scrollView.bounds
            newFrame.origin.x = newFrame.width * CGFloat(cellIndex)
            skimCell.frame = newFrame
            skimCell.tag = cellIndex
            scrollView.addSubview(skimCell)
        }
    }
    
}
