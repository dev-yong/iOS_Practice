//
//  ViewController.swift
//  Youtube
//
//  Created by 이광용 on 2017. 12. 4..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var slideUnderLine: UIView!
    @IBOutlet weak var slideUnderLineLeadingConstraint: NSLayoutConstraint!
    let menuList = ["Home", "Trending", "Subscriptions", "Account"]
    let transitionManager: TransitionManager = TransitionManager()
    @IBOutlet weak var slideInMenuView: slideInMenuView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let toVC = segue.destination as! VideoController
        toVC.transitioningDelegate = self.transitionManager
    }

    
    func setUpViewController()
    {
        setUpNavBar()
        setUpMenu()
    }
    
    func setUpNavBar()
    {
        self.navigationController?.hidesBarsOnSwipe = true
        let navBar = self.navigationController?.navigationBar
        navBar?.tintColor = UIColor.white
        navBar?.backIndicatorImage = UIImage()//Get rid of navigationBar Bottom Line
        
        //Algin Title Left
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 25)
        titleLabel.textAlignment = .left
        
        self.navigationItem.titleView = titleLabel        
    }
    
    func setUpMenu()
    {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.register(UINib(nibName: "menuCell", bundle: nil)
            , forCellWithReuseIdentifier: "menuCell")
        let selectedIndex = IndexPath(item: 0, section: 0)
        menuCollectionView.selectItem(at: selectedIndex, animated: true, scrollPosition: .top)
    }
    
    @IBAction func touchUpMoreButton(_ sender: UIBarButtonItem) {
        //First,  Outside ViewController, you need to create 'slideInMenuView'
        slideInMenuView.vcDelegate = self
        slideInMenuView.setUp()
        
    }
    
    func showVC()
    {
        //self.navigationController?.show(SampleController(), sender: nil)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SampleController") as? SampleController else{return}
        self.present(nextViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}   

extension  ViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as! menuCell
        cell.imageView.image = UIImage(named: menuList[indexPath.row])?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        return cell
    }
    
}

//CollectionView Cell Size, Layout
extension ViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: menuCollectionView.bounds.size.width/CGFloat(menuList.count), height: menuCollectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
extension ViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 1, animations: {
            self.slideUnderLineLeadingConstraint.constant = CGFloat(indexPath.row) * (self.menuCollectionView.frame.width/CGFloat(self.menuList.count))
            self.view.layoutIfNeeded()
        })
    }
}

