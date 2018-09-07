//
//  ViewController.swift
//  ReusableScrollViewDemo
//
//  Created by Teresa on 2018/7/25.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    let skimView = XYXSkimView()
    let smallSkimView = XYXSkimView()
    @IBOutlet weak var xibSkimView: XYXSkimView!
    @IBOutlet weak var specialSkimView: XYXSkimView!
    
    let specialCount:Int = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //=------
        skimView.frame = CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 80)
        skimView.dataSource = self
        view.addSubview(skimView)
        skimView.register(DemoView.self, forCellReuseIdentifier: "DemoView")

        //=------
        smallSkimView.frame = CGRect(x: 0, y: 150, width: UIScreen.main.bounds.width, height: 80)
        view.addSubview(smallSkimView)
        smallSkimView.register(UINib.init(nibName: "SmallDemoView", bundle: nil), forCellReuseIdentifier: "SmallDemoView")
        smallSkimView.dataSource = self
        smallSkimView.scrollTo(page: 2, animated:true)
        //=------
        xibSkimView.register(DemoView.self, forCellReuseIdentifier: "DemoView")
        xibSkimView.dataSource = self
        xibSkimView.scrollTo(page: 1)

        //=------
        specialSkimView.register(DemoView.self, forCellReuseIdentifier: "DemoView")
        specialSkimView.register(UINib.init(nibName: "SmallDemoView", bundle: nil), forCellReuseIdentifier: "SmallDemoView")
        specialSkimView.dataSource = self
        specialSkimView.scrollTo(page: 1)

    }
    
}

extension ViewController: XYXSkimViewDataSource {
    
    func numberOfPages(in skimView: XYXSkimView) -> Int {
        switch skimView {
        case self.smallSkimView:
            return 7
        case self.specialSkimView:
            return specialCount
        default:
            return 4
        }
    }
    
    func skimView(_ skimView: XYXSkimView, cellForRowAt index: Int) -> XYXSkimViewCell {
        
        if skimView == self.skimView || skimView == self.xibSkimView{
            var cell = skimView.dequeueReusableCell(withIdentifier: "DemoView") as? DemoView
            if cell == nil{
                cell = DemoView.init(reuseIdentifier: "DemoView")
            }
            cell?.flag = index
            return cell!
        }else if skimView == self.smallSkimView {
            var cell = skimView.dequeueReusableCell(withIdentifier: "SmallDemoView") as? SmallDemoView
            if cell == nil{
                cell = Bundle.main.loadNibNamed("SmallDemoView", owner: nil, options: nil)?.last as? SmallDemoView
            }
            cell?.flag = index
            return cell ?? XYXSkimViewCell()
        }
        else if skimView == self.specialSkimView {
            
            if index == specialCount - 1 {
                var cell = skimView.dequeueReusableCell(withIdentifier: "DemoView") as? DemoView
                if cell == nil{
                    cell = DemoView.init(reuseIdentifier: "DemoView")
                }
                cell?.flag = index
                return cell!
            }else{
                var cell = skimView.dequeueReusableCell(withIdentifier: "SmallDemoView") as? SmallDemoView
                if cell == nil{
                    cell = Bundle.main.loadNibNamed("SmallDemoView", owner: nil, options: nil)?.last as? SmallDemoView
                }
                cell?.flag = index
                return cell!
            }
            
        }
        return XYXSkimViewCell()
    }
}

