//
//  ViewController.swift
//  CircleScratchCard
//
//  Created by huangxiong on 15/6/6.
//  Copyright (c) 2015年 huangxiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var scratchView: ScratchView = ScratchView(frame: CGRectMake(0, 100, 375, 235))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.scratchView.backgroundColor = UIColor.redColor()
        
        self.view.addSubview(self.scratchView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetImageView(sender: UIButton) {
        self.scratchView.resetScratchView()
    }

}

