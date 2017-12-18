//
//  FeedCollectionViewCell.swift
//  FaceBook
//
//  Created by 이광용 on 2017. 11. 23..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit
import Kingfisher

class FeedCollectionViewCell: UICollectionViewCell {
    var feedController: FeedController?
    
    var post:Post?{
        didSet{
            guard let name = post?.name else {return}
            guard let time = post?.time else {return}
            guard let statusText = post?.statusText else {return}
            guard let profile = post?.profileImg else {return}
            guard let statusImgURL = post?.statusImgURL else {return}
            let attributedString = NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
            let timeAttributedString = NSMutableAttributedString(string: "\n" + time + " • ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)])
            
            //Attach Image
            let attachmentImage = NSTextAttachment()
            attachmentImage.image = #imageLiteral(resourceName: "earth").withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            attachmentImage.bounds = CGRect(x: 0, y: -1, width: 10, height: 10)
            let attributedImage = NSAttributedString(attachment: attachmentImage)
            
            timeAttributedString.append(attributedImage)
            timeAttributedString.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.lightGray], range: NSMakeRange(0, timeAttributedString.string.count))
            
            //Paragraph Style 문단 간격
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            attributedString.addAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.string.count))
            
            attributedString.append(timeAttributedString)
            nameLabel.attributedText = attributedString
            profileImg.image = UIImage(named: profile)
            statusTextView.text = statusText
            
            feedImageView.kf.indicatorType = .activity
            let url = URL(string: statusImgURL)
            feedImageView.kf.setImage(with: url)
        }
    }
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var profileImg: RoundedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusTextView: UITextView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var feedImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        setupCell()
    }
    
    func setupCell(){
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        widthConstraint.constant = UIScreen.main.bounds.size.width
        self.backgroundColor = UIColor.white
        statusTextView.font = UIFont.systemFont(ofSize: 14)
        statusTextView.isScrollEnabled = false
        feedImageView.contentMode = .scaleAspectFill
        feedImageView.layer.masksToBounds = true
        feedImageView.isUserInteractionEnabled = true
        feedImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FeedCollectionViewCell.zoomIn)))
    }
    
    @objc func zoomIn()
    {
        feedController?.animateToCenter(feedImageView: feedImageView)
    }
    
}
