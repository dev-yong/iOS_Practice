//
//  PhotoViewController.swift
//  RealmExample
//
//  Created by 이광용 on 2018. 1. 23..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedAlbum: Album!
    var photoArray: Results<Photo>!
    var token: NotificationToken!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        photoArray = selectedAlbum.photos.sorted(byKeyPath: "saveDate", ascending: false)
        token = photoArray.observe({ (change) in
            self.collectionView.reloadData()
        })
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add
            , target: self, action: #selector(addPhoto))
    }
    
    @objc func addPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
        cell.imageView.image = UIImage(data: photoArray[indexPath.item].imageData)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 2.5 * 3 ) / 4
        return CGSize(width: width, height: width)
    }
}

extension PhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let newPhoto = Photo()
        newPhoto.imageData = UIImagePNGRepresentation(selectedImage)!
        do {
            try Album.realm.write {
            self.selectedAlbum.photos.append(newPhoto)
            }
        }
        catch {
            print(error.localizedDescription)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

class PhotoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}
