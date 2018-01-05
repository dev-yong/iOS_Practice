//
//  ViewController.swift
//  VideoTutorial
//
//  Created by 이광용 on 2018. 1. 2..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer
import MobileCoreServices

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func startMediaBrowserFromViewController(viewController: UIViewController, usingDelegate delegate: UINavigationControllerDelegate & UIImagePickerControllerDelegate) -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) == false {
            return false
        }
        
        let mediaUI = UIImagePickerController()
        mediaUI.sourceType = .savedPhotosAlbum
        mediaUI.mediaTypes = [kUTTypeMovie as String]
        mediaUI.allowsEditing = true
        mediaUI.delegate = delegate
        
        present(mediaUI, animated: true, completion: nil)
        return true
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        startMediaBrowserFromViewController(viewController: self, usingDelegate: self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        let videoURL = info[UIImagePickerControllerMediaURL] as! URL
        dismiss(animated: true) { 
            if mediaType == kUTTypeMovie {
                let player = AVPlayer(url: videoURL)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                self.present(playerViewController, animated: true, completion: {
                    playerViewController.player!.play()
                })
            }
        }
    }
}

extension ViewController: UINavigationControllerDelegate {
    
}


