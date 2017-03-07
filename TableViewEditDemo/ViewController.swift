//
//  ViewController.swift
//  TableViewEditDemo
//
//  Created by 默司 on 2017/3/7.
//  Copyright © 2017年 默司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let vc = DemoTableViewController()
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
        
        vc.view.frame = UIScreen.main.bounds.divided(atDistance: 20, from: .minYEdge).remainder
        
        vc.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

