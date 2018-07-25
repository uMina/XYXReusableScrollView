//
//  XYXSkimViewCell.swift
//  XYXReusableScrollViewDemo
//
//  Created by Teresa on 2018/7/24.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

open class XYXSkimViewCell: UIView {
    
    @IBInspectable private var _reuseIdentifier:String?
    open var reuseIdentifier: String? {
        get{
           return _reuseIdentifier
        }
    }
    
    public convenience init(){
        self.init()
    }
    
    required public init(reuseIdentifier:String) {
        super.init(frame: CGRect.zero)
        _reuseIdentifier = reuseIdentifier
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
