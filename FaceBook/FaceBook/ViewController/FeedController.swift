//
//  ViewController.swift
//  FaceBook
//
//  Created by 이광용 on 2017. 11. 23..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class FeedController: UICollectionViewController{
    var postList = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.estimatedItemSize = CGSize(width: 200, height: 400)
        }
        setupFeedController()
    }
    
    func setupFeedController(){
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.alwaysBounceVertical = true
        
        
        postList.append(Post(name: "버즈 라이트이어",
                             time: "11월 22일 오후 9:30",
                             statusText: "오늘은 하품하는 개를 가져왔습니다.",
                             profileImg: "buzz",
                             statusImgURL: "https://i.pinimg.com/564x/4e/42/ee/4e42eeb02c1217a676064f28056245d4.jpg"))
            
        postList.append(Post(name: "우디", time: "11월 22일 오후 9:30", statusText: """
            난 너의 친구야
            영원한 친구야

            너 어렵고 힘들때
            누구에게 의지하고 싶을때
            내가 있다는 사실 잊지마

            그래 난 너의 친구야
            예 영원한 친구야

            난 너의 친구야
            영원한 친구야
            """, profileImg:"woody", statusImgURL: "https://i.pinimg.com/564x/23/5c/28/235c280ec0749d4fa510c399281aedcd.jpg"))
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionViewCell", for: indexPath) as! FeedCollectionViewCell
        cell.post = postList[indexPath.row]
        cell.feedController = self
        return cell
    }

    
    let blackView = UIView()
    let subView = UIImageView()
    var feedImageView: UIImageView?
    
    @objc func animateToCenter(feedImageView: UIImageView)
    {
        self.feedImageView = feedImageView
        
        if let startingFrame = feedImageView.superview?.convert(feedImageView.frame, to: nil)
        {
            feedImageView.alpha = 0
            blackView.backgroundColor = UIColor.black
            blackView.frame = self.view.frame
            blackView.alpha = 0
            view.addSubview(blackView)
            
            subView.image = feedImageView.image
            subView.contentMode = feedImageView.contentMode
            subView.clipsToBounds = true
            subView.frame = startingFrame
            subView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FeedController.zoomOut)))
            subView.isUserInteractionEnabled = true
            view.addSubview(subView)
            
            UIView.animate(withDuration: 0.75, animations: {()->Void in
                let height = self.subView.frame.height
                let yPos = self.view.frame.height / 2 - height / 2
                self.subView.frame = CGRect(x: 0, y: yPos,
                                         width: self.view.frame.width,
                                         height: height)
                self.navigationController?.navigationBar.alpha = 0
                self.blackView.alpha = 1
            })
        }
    }
    
    @objc func zoomOut()
    {
        
        if let startingFrame = feedImageView!.superview?.convert(feedImageView!.frame, to: nil)
        {
            UIView.animate(withDuration: 0.75, animations:{()->Void in
                self.subView.frame = startingFrame
                self.blackView.alpha = 0
                self.navigationController?.navigationBar.alpha = 1
            }, completion: { (didComplete) in
                self.subView.removeFromSuperview()
                self.blackView.removeFromSuperview()
                self.feedImageView?.alpha = 1
            })
        }
    }
}
