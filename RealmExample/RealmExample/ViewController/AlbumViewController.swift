//
//  AlbumViewController.swift
//  RealmExample
//
//  Created by 이광용 on 2018. 1. 22..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit
import RealmSwift

class AlbumViewController: UIViewController {
    private var token: NotificationToken!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var albumArray = Album.realm.objects(Album.self).sorted(byKeyPath: "saveDate", ascending: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        token = albumArray.observe({ (change) in
            self.tableView.reloadData()
        })
        searchBar.delegate = self
    }
    
    @IBAction func addAlbumAction(_ sender: UIBarButtonItem) {
        alertForAlbumTitle(nil)
    }
    
    func alertForAlbumTitle(_ albumToBeUpdated: Album?) {
        let alertController = UIAlertController(title: "Album", message: "Insert Album Title", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            if let oldAlbum = albumToBeUpdated {
                textField.text = oldAlbum.title
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            let title = alertController.textFields?.first?.text
            if let oldAlbum = albumToBeUpdated {
                try! Album.realm.write {
                    oldAlbum.title = title!
                }
            }
            else {
                let album = Album()
                album.title = title!
                Album.addToRealm(album)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AlbumTableViewCell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.reuseIdentifier, for: indexPath) as! AlbumTableViewCell
        cell.title.text = albumArray[indexPath.row].title
        if let imageData = albumArray[indexPath.row].photos.sorted(byKeyPath: "saveDate", ascending: false).first?.imageData {
            cell.thumbnail.image = UIImage(data: imageData, scale: 0.1)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (deleteAction, indexPath) in
            try! Album.realm.write {
                Album.realm.delete(self.albumArray[indexPath.row].photos)
            }
            Album.removeFromRealm(self.albumArray[indexPath.row])
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (editAction, indexPath) in
            self.alertForAlbumTitle(self.albumArray[indexPath.row])
        }
        
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC: PhotoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: PhotoViewController.reuseIdentifier) as! PhotoViewController
        nextVC.selectedAlbum = albumArray[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
}

extension AlbumViewController: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            self.albumArray = Album.realm.objects(Album.self).filter("title contains '\(searchText)'").sorted(byKeyPath: "saveDate", ascending: false)
        } else {
            self.albumArray = Album.realm.objects(Album.self).sorted(byKeyPath: "saveDate", ascending: false)
        }
        self.tableView.reloadData()
    }
}

class AlbumTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func prepareForReuse() {
        thumbnail.image = #imageLiteral(resourceName: "icon_person")
    }
    
}
