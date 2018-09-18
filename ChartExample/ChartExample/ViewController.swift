//
//  ViewController.swift
//  ChartExample
//
//  Created by 이광용 on 2018. 2. 1..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit
import KDCircularProgress
import Charts

class ViewController: UIViewController {
    @IBOutlet weak var circularProgress: KDCircularProgress!
    @IBOutlet weak var barChart: BarChartView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circularProgress.animate(fromAngle: 0, toAngle: 230, duration: 2) { (completed) in
            if completed {}
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func slideValue(_ sender: UISlider) {
        circularProgress.angle = Double(sender.value)
    }
    
}

