//
//  ViewController.swift
//  LOTTIE_Example
//
//  Created by 이광용 on 2018. 1. 30..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit
import Lottie
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lottieView: UIView!
    var animationView: LOTAnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animationView = LOTAnimationView(name: "Transition")
        let imageView = UIImageView(image: #imageLiteral(resourceName: "wallpaper"))
        animationView?.addSubview(imageView , toKeypathLayer: LOTKeypath(string: "Placeholder"))
        //let cgPoint = animationView?.convert(CGPoint(), fromKeypathLayer: LOTKeypath(string: "Placeholder"))
        //imageView.center = cgPoint!
        animationView?.frame = self.lottieView.frame
        
        
        //imageView.center = (animationView?.center)!
        self.view.addSubview(animationView!)
        animationView?.loopAnimation = true
        animationView?.play()
    }


}

