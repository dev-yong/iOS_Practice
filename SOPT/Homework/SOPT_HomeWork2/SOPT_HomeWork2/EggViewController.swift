//
//  EggViewController.swift
//  SOPT_HomeWork2
//
//  Created by 이광용 on 2017. 10. 31..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class EggViewController: UIViewController {
    //MARK:- Properties
    @IBOutlet weak var eggImage: UIImageView!
    @IBOutlet weak var brokenEggImage: UIImageView!
    @IBOutlet weak var picachu: UIImageView!
    
    var count:Int!
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initImage()
    }
    
    func initImage() -> Void  {
        count = 0
        eggImage.image = #imageLiteral(resourceName: "egg")
        brokenEggImage.image = #imageLiteral(resourceName: "egg-broken")
        picachu.image = #imageLiteral(resourceName: "피카츄.jpg")
        isHiddenSet(0)
    }
    //MARK:- IBAction
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        
        count = count + 1
        print("tap : "+"\(count)")
        let value = Double(count) * 3.0
        eggImage.shake(value)
        if(count > 10){
            isHiddenSet(1)
        }
    }
    
    @IBAction func brokentapGesture(_ sender: UITapGestureRecognizer) {
        isHiddenSet(2)
        picachu.expand()
    }
   
    @IBAction func picachutapGesture(_ sender: UITapGestureRecognizer) {
        print("피카")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextViewController = storyBoard.instantiateViewController(withIdentifier: PicachuContentViewController.reuseIdentifier) as? PicachuContentViewController else {return}
        present(nextViewController, animated: true, completion: nil)
    }
    
    func isHiddenSet(_ n: Int){
        eggImage.isHidden = true
        brokenEggImage.isHidden = true
        picachu.isHidden = true
        switch (n) {
        case 0:
            eggImage.isHidden = false
            break
        case 1:
            brokenEggImage.isHidden = false
            break
        case 2:
            picachu.isHidden = false
            break
        default:
            break
        }
    }
    @IBAction func resetBtnTouchUp(_ sender: UIButton) {
        initImage()
    }
}

extension UIView
{
    public func shake(_ value: Double) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-value, value, -value*(2/3), value*(2/3), -value*(1/3), value*(1/3), 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    func expand(){
        self.transform = self.transform.scaledBy(x: 0.25, y: 0.25)
        
        UIView.animate(withDuration: 1.2,
                       delay: 0.0,
                       usingSpringWithDamping: 1.5,
                       initialSpringVelocity: 0.1,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: ({
                        self.transform = self.transform.scaledBy(x: 4.0, y: 4.0)
                       }),
                       completion: nil)
    }
    
}
