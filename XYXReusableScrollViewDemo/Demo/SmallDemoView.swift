//
//  SmallDemoView.swift
//  XYXReusableScrollViewDemo
//
//  Created by Teresa on 2018/7/24.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

class SmallDemoView: XYXSkimViewCell {
    
    @IBOutlet weak var displayBtn: UIButton!
    
    var flag:Int = 0{
        didSet{
            let text = "第\(flag)页"
            displayBtn.setTitle(text, for: UIControlState.normal)
            backgroundColor = self.randomColor()
        }
    }
    
    func randomColor() -> UIColor {
        return UIColor(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1)
    }

}
