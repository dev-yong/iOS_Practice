//
//  ViewController.swift
//  BlurEffectImageCell
//
//  Created by 이광용 on 2018. 4. 16..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit
import GPUImage
import FXBlurView

struct CellInfo {
    let image: UIImage
    let value: CGFloat
}
class TableViewCell: UITableViewCell {
    @IBOutlet var thumbnail: UIImageView!
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let cellInfos: [CellInfo] = [CellInfo(image: #imageLiteral(resourceName: "Sample1"), value: 0),
                                 CellInfo(image: #imageLiteral(resourceName: "Sample2"), value: 10),
                                 CellInfo(image: #imageLiteral(resourceName: "Sample3"), value: 0.2),
                                 CellInfo(image: #imageLiteral(resourceName: "Sample4"), value: 0.3),
                                 CellInfo(image: #imageLiteral(resourceName: "Sample2"), value: 0.4),
                                 CellInfo(image: #imageLiteral(resourceName: "Sample4"), value: 0.5),
                                 CellInfo(image: #imageLiteral(resourceName: "Sample1"), value: 0.6),
                                 CellInfo(image: #imageLiteral(resourceName: "Sample1"), value: 0.7),
                                 CellInfo(image: #imageLiteral(resourceName: "Sample3"), value: 1),]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.thumbnail.image = self.cellInfos[indexPath.row].image.applyBlurEffect(radius: self.cellInfos[indexPath.row].value)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellInfos.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 5
    }
    
    
}

extension UIImage {
    func applyBlurEffect(radius: CGFloat) -> UIImage? {
        let gpuBlurFilter = GPUImageGaussianBlurFilter()

        gpuBlurFilter.blurRadiusInPixels = radius

        return gpuBlurFilter.image(byFilteringImage: self)
    }
}

