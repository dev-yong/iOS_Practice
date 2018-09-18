//
//  AssetSelectorViewController.swift
//  VideoTutorial
//
//  Created by 이광용 on 2018. 1. 2..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit
import Photos
class AssetSelectorViewController: UIViewController {    
    var fetchResult: PHFetchResult<PHAsset>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLibrary()
    }
    
    func loadLibrary() {
        PHPhotoLibrary.requestAuthorization { (status) in
            if status == .authorized {
                self.fetchResult = PHAsset.fetchAssets(with: .video, options: nil)
            }
        }
    }
    
    func loadAsset(_ asset: AVAsset) {
        //URL To AVAsset : AVAsset(url: URL)
        
        // override in subclass
    }
}
