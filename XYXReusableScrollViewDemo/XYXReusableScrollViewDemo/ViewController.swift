//
//  ViewController.swift
//  XYXReusableScrollViewDemo
//
//  Created by Teresa on 2018/7/19.
//  Copyright © 2018年 Teresa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let skimView = XYXSkimView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skimView.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 80)
        skimView.backgroundColor = UIColor.lightGray
        view.addSubview(skimView)
        
        skimView.register(DemoView.classForCoder(), forCellReuseIdentifier: "DemoView")
        skimView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: XYXSkimViewDataSource {
    
    func numberOfPages(in skimView: XYXSkimView) -> Int {
        return 3
    }
    func skimView(_ skimView: XYXSkimView, cellForPageAt pageIndex: Int) -> UIView {
        var cell = skimView.dequeueReusableCell(withIdentifier: "DemoView") as? DemoView
        if cell == nil{
            cell = DemoView(frame: skimView.frame)
        }
        cell?.flag = pageIndex
        return cell!
    }
}
