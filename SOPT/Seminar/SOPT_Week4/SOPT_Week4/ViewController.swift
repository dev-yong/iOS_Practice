//
//  ViewController.swift
//  SOPT_Week4
//
//  Created by 이광용 on 2017. 11. 11..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate {
    //MARK:- Properties
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    //MARK:- Methods
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: IBAction
    @IBAction func tapImageView(_ sender: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: "사진을 선택해주세요.", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let photoLibraryAction = UIAlertAction(title: "사진 앨범", style: .default, handler: {
            (action:UIAlertAction)
                in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        alertController.addAction(cancelAction)
        alertController.addAction(photoLibraryAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage
        {
            self.imageView.image = editedImage
        }
        
        defer { //method가 종료될 때 무조건 호출해야함
            self.dismiss(animated: true, completion: nil)
        }
    }
}


