//
//  ViewController.swift
//  SOPT_HomeWork1_4
//
//  Created by 이광용 on 2017. 9. 25..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var sec = 30
    var score = 0
    var timer = Timer()
    var resumeTapped = false
    var random_timer = Timer()
    var random_num:UInt32 = 0
    
    @IBOutlet weak var count_Label: UILabel!
    @IBOutlet weak var timer_Down_Label: UILabel!
    @IBOutlet weak var random_Label: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var odd_Label: UILabel!
    @IBOutlet weak var even_Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer_Down_Label.text = "\(sec)"
        count_Label.text = "\(score)"
        random_Label.text = "0"
        odd_Label.text = "홀수 정답 :"
        even_Label.text = "짝수 정답 :"
    }
    func reset(){
        if(sec == 0){
            //show alert Message
            //stop the timer
            timer.invalidate()
            random_timer.invalidate()
            
            timer_Down_Label.text = "\(sec)"
            let alertController = UIAlertController(title: "게임 종료", message: "\(score)"+"개 맞추셨습니다.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(cancelAction )
            self.present(alertController, animated: true, completion: nil)
            //show start Button
            startBtn.isHidden=false
            
            score = 0
            count_Label.text = "\(score)"
            sec = 30
            timer_Down_Label.text="\(sec)"
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Start_Btn(_ sender: UIButton) {
        runTimer()
        odd_Label.text = "홀수 정답 :"
        even_Label.text = "짝수 정답 :"
        sender.isHidden = true
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        
        random_timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateRandomTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer()
    {
        sec -= 1
        timer_Down_Label.text = "\(sec)"
        reset()
    }
    @objc func updateRandomTimer(){
        random_num = arc4random_uniform(300)
        random_Label.text = "\(random_num)"
    }
    @IBAction func Odd_Action(_ sender: Any) {
        if(random_num%2 == 1){
            score += 1
            count_Label.text = "\(score)"
            odd_Label.text! += " \(random_num)"
        }
    }
    @IBAction func Even_Action(_ sender: Any) {
        if(random_num%2 == 0){
            score += 1
            count_Label.text = "\(score)"
            even_Label.text! += " \(random_num)"
        }
    }
}
