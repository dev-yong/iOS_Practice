//
//  PicachuViewController.swift
//  SOPT_HomeWork2
//
//  Created by 이광용 on 2017. 10. 31..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class PicachuViewController: UIViewController {

    //MARK:- Properties
    var damage:Int!
    var count:Int!
    var HP:Int!
    var performSegueValue:Bool = false
    
    @IBOutlet weak var picachuImage: UIImageView!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var monsterBallStack: UIStackView!
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        initView()
    }
    func initView() -> Void {
        count = 0
        damage = 0
        HP = 500
        hpCalculate(HP, count)
        progress.reverse()
        monsterBallStack.removeAllSubViews()
    }
    
    func hpCalculate(_ hp:Int, _ cnt:Int) -> Void {
        let maxHP = 500
        hpLabel.text = "\(hp) / \(maxHP)"
        progress.setProgress(Float(hp)/500, animated: true)
        countLabel.text = "몬스터볼 던진 횟수 : \(cnt)개"
    }
    //MARK:- IBAction
    @IBAction func tapGesture(_ sender: Any) {
        let monsterBall_16:UIImageView = UIImageView()
        let monsterBall_32:UIImageView = UIImageView()
        monsterBall_16.image = #imageLiteral(resourceName: "pokeball16")
        monsterBall_16.contentMode = .center
        monsterBall_32.image = #imageLiteral(resourceName: "pokeball32")
        monsterBall_32.contentMode = .center
        
        let Max:UInt32 = 45
        let Min:UInt32 = 5
        damage = Int(arc4random_uniform(Max) + Min)
        picachuImage.shake(Double(damage))
        
        if(monsterBallStack.arrangedSubviews.count == 10 ){
            monsterBallStack.removeAllSubViews()
        }
        if(HP - damage < 0){
            HP = 0
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            guard let nextViewController:PicachuContentViewController = storyBoard.instantiateViewController(withIdentifier: PicachuContentViewController.reuseIdentifier) as? PicachuContentViewController else {return}
            present(nextViewController, animated: true, completion: nil)
            
       }
        else {
            HP = HP - damage
            count = count + 1
            if(damage > 25){ //Critical Damage
                monsterBallStack.addArrangedSubview(monsterBall_32)
            }
            else{
                monsterBallStack.addArrangedSubview(monsterBall_16)
            }
        }
        hpCalculate(HP, count)
        debugPrint("\(monsterBallStack.arrangedSubviews.count)")
    }
}

extension UIStackView
{
    func removeAllSubViews() -> Void {
        for item in self.arrangedSubviews{
            self.removeArrangedSubview(item)
            item.removeFromSuperview()
        }
    }
}
extension UIView
{
    func reverse() {
        let degree = (180 * M_PI) / 180
        self.transform = CGAffineTransform(rotationAngle: CGFloat(degree))
    }
}
