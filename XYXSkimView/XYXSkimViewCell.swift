//
//  XYXSkimViewCell.swift
//  XYXReusableScrollViewDemo
//
//  Created by Teresa on 2018/7/24.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

open class XYXSkimViewCell: UIView {
    
    @IBInspectable private var identifier:String?
    open var reuseIdentifier: String? {
        get{
           return identifier
        }
    }
    
    public convenience init(){
        self.init()
    }
    
    required public init(reuseIdentifier:String) {
        super.init(frame: CGRect.zero)
        identifier = reuseIdentifier
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
