//
//  XYXSkimViewReusableCellModel.swift
//  XYXReusableScrollViewDemo
//
//  Created by Teresa on 2018/7/19.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

class XYXSkimViewReusableCellModel: NSObject {
    var view:UIView!
    var reuseIdentifier:String!
    
    init(view:UIView, reuseIdentifier:String) {
        super.init()
        self.view = view
        self.reuseIdentifier = reuseIdentifier
    }
}

class XYXSkimViewVisibleCellModel: NSObject{
    var view:UIView!
    var index:Int!
    
    init(view:UIView, index:Int) {
        super.init()
        self.view = view
        self.index = index
    }
}
