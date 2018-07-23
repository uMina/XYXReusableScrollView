//
//  DemoViewController.swift
//  XYXReusableScrollViewDemo
//
//  Created by Teresa on 2018/7/19.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

class DemoView: UIView {
    let displayLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.purple
        return label
    }()
    
    var flag:Int = 0{
        didSet{
            displayLabel.text = "第\(flag)页"
            displayLabel.sizeToFit()
            backgroundColor = UIColor.yellow
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(displayLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        layoutIfNeeded()
        print("-------didMoveToSuperview()")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        displayLabel.center = self.center
        backgroundColor = self.randomColor()
        print("-------layoutSubviews()")
    }
    
    func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1)
    }
}
