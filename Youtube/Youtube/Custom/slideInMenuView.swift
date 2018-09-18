//
//  slideInMenuView.swift
//  Youtube
//
//  Created by 이광용 on 2017. 12. 6..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

@IBDesignable
class slideInMenuView: UIView {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var menuTableView: UITableView!
    var vcDelegate: ViewController?
    
    func setUp()
    {
        self.backgroundColor = UIColor.clear
        let guide = vcDelegate?.view.safeAreaLayoutGuide
        print(guide?.layoutFrame)
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0
        menuTableView.register(UINib(nibName: "SlideInCell", bundle: nil), forCellReuseIdentifier: "SlideInCell")
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        guard let window = UIApplication.shared.keyWindow else {return}
        window.addSubview(self)
        self.frame = (guide?.layoutFrame)!
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
        
        let tableHeight = menuTableView.frame.height
        menuTableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: tableHeight)
        
        UIView.animate(withDuration: 1.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.backgroundView.alpha = 0.5
                        self.menuTableView.frame = CGRect(x: 0, y: window.frame.height - tableHeight, width: window.frame.width, height: tableHeight)
        },
                       completion: nil)
    }
    
    @objc func dismiss()
    {
        print("tap")
        guard let window = UIApplication.shared.keyWindow else {return}

        let tableHeight = menuTableView.frame.height
        menuTableView.frame = CGRect(x: 0, y: window.frame.height - tableHeight, width: window.frame.width, height: tableHeight)

        UIView.animate(withDuration: 1, animations: {
            self.backgroundView.alpha = 0
            self.menuTableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: tableHeight)
        }){ (completion: Bool) in
            self.removeFromSuperview()
        }
    }
}

extension slideInMenuView: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "SlideInCell", for: indexPath) as! SlideInCell
        return cell
    }
}

extension slideInMenuView: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        dismiss()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let next = storyboard.instantiateViewController(withIdentifier: "SampleController") as! SampleController
        self.vcDelegate?.navigationController?.pushViewController(next, animated: true)
    }
}
