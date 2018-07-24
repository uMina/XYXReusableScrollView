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
    
    var flag:Int = 0{
        didSet{
            displayLabel.text = "第\(flag)页"
            displayLabel.sizeToFit()
            backgroundColor = UIColor.yellow
        }
    }
    
    required init(reuseIdentifier: String) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubview(displayLabel)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        displayLabel.frame = CGRect(origin: CGPoint(x: 20, y: 20), size: displayLabel.frame.size)
        backgroundColor = self.randomColor()
    }
    
    func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1)
    }
}
