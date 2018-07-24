//
//  XYXReusableScrollView.swift
//  XYXReusableScrollViewDemo
//
//  Created by Teresa on 2018/7/19.
//  Copyright © 2018年 Teresa. All rights reserved.
//
//  横屏、可复用的滑动视图

import UIKit

@objc protocol XYXSkimViewDataSource {
    func numberOfRows(in skimView: XYXSkimView) -> Int
    func skimView(_ skimView: XYXSkimView, cellForRowAt index: Int) -> XYXSkimViewCell
    @objc optional func skimView(_ skimView: XYXSkimView, widthForRow at:Int) -> Float
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
            configueCell(at: currentPageIndex)
        }
    }

    var pagingEnabled = true{
        didSet{
            scrollView.isPagingEnabled = pagingEnabled
        }
    }
    
    fileprivate let scrollView = UIScrollView()
    fileprivate var visibleViews:[XYXSkimViewCell] = []
    fileprivate var reusedViews:[XYXSkimViewCell] = []
    fileprivate let defaultCellWidth:CGFloat = UIScreen.main.bounds.width
    
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
    }
    
    func baseSetting() {
        scrollView.frame = frame
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
            let isIncluded = reusedViews.contains { (cell) -> Bool in
                return cell.reuseIdentifier == identifier
            }
            if isIncluded == false{
                reusedViews.append(cell)
            }
        }
    }
    
    open func register(_ cellClass: XYXSkimViewCell.Type, forCellReuseIdentifier identifier: String){
        let cell = cellClass.init(reuseIdentifier: identifier)
        let isIncluded = reusedViews.contains { (view) -> Bool in
            return cell.reuseIdentifier == identifier
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
    open func reloadData() {
        let cellCount = CGFloat(dataSource?.numberOfRows(in: self) ?? 0)
        scrollView.contentSize = CGSize(width: scrollView.frame.width * cellCount, height: scrollView.frame.height)
        configueCell(at: currentPageIndex)
    }

}
extension XYXSkimView:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.skimViewDidScroll(self, offsetX: scrollView.contentOffset.x)
        
        // 索引器
        let cellCount = dataSource?.numberOfRows(in: self) ?? 0
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
            print("被移除的view:\(reduceItem.address())(tag:\(reduceItem.tag))")
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

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        var rs:String = ""
        let count = scrollView.subviews.count
        for view in scrollView.subviews {
            rs.append("\(view.address())(tag:\(view.tag)) - ")
        }
        rs.append("cell总数:\(count)")
        print(rs)
    }
}

//MARK: - Private
extension XYXSkimView{
    private func configueCell(at cellIndex:Int) {
        
        if let skimCell = dataSource?.skimView(self, cellForRowAt: cellIndex) {
            
            //CellModel处理
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

extension UIView{
    func address() -> String {
        return String.init(format: "%018p", unsafeBitCast(self, to: Int.self))
    }
}
