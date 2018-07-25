//
//  DemoViewController.swift
//  XYXReusableScrollViewDemo
//
//  Created by Teresa on 2018/7/19.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

class DemoView: XYXSkimViewCell {
    let displayLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.purple
        return label
    }()
    let displayLabel2:UILabel = {
        let label = UILabel()
        label.text = "从代码初始化"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.sizeToFit()
        return label
    }()
    
    var flag:Int = 0{
        didSet{
            displayLabel.text = "第\(flag)页"
            displayLabel.sizeToFit()
            backgroundColor = UIColor.yellow
        }
    }
    
    required init(reuseIdentifier: String) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(displayLabel2)
        addSubview(displayLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        displayLabel2.frame = CGRect(origin: CGPoint(x: 10, y: 10), size: displayLabel2.frame.size)
        displayLabel.frame = CGRect(origin: CGPoint(x: 120, y: 10), size: displayLabel.frame.size)
        displayLabel2.textColor = self.randomColor()
        backgroundColor = self.randomColor()
    }
    
    func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1)
    }
}
