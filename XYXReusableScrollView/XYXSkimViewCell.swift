//
//  XYXSkimViewCell.swift
//  XYXReusableScrollViewDemo
//
//  Created by Teresa on 2018/7/24.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

class XYXSkimViewCell: UIView {
    
    @IBInspectable private var _reuseIdentifier:String?
    open var reuseIdentifier: String? {
        get{
           return _reuseIdentifier
        }
    }
    
    convenience init(){
        self.init()
    }
    
    required init(reuseIdentifier:String) {
        super.init(frame: CGRect.zero)
        _reuseIdentifier = reuseIdentifier
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
