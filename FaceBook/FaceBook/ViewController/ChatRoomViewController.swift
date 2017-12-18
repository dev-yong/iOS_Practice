//
//  ChatRoomViewController.swift
//  FaceBook
//
//  Created by 이광용 on 2017. 11. 26..
//  Copyright © 2017년 이광용. All rights reserved.
//

import UIKit

class ChatRoomViewController: UIViewController {
    @IBOutlet weak var chatRoomTableView: UITableView!
    var messages: [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chatRoomTableView.delegate = self
        self.chatRoomTableView.dataSource = self
        self.chatRoomTableView.separatorStyle = .none
        setupData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ChatRoomViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let nextViewController = storyBoard.instantiateViewController(withIdentifier: ChatLogViewController.getIdentifier) as? ChatLogViewController else{return}
        nextViewController.friend = messages?[indexPath.row].friend
        nextViewController.hidesBottomBarWhenPushed = true//Hide TabBar at Next ViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

extension ChatRoomViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = messages?.count else {return 0}
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: RoomChatCell.getIdentifier , for: indexPath) as! RoomChatCell
        cell.message = messages?[indexPath.row]
        return cell
    }
}

import CoreData
extension ChatRoomViewController
{
    func setupData()
    {
        clearData()
        //let woody = Friend()
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = delegate.persistentContainer.viewContext

        let woody = createFriend(name: "우디 프라이드", profileImg: "woody", context: context)
        createMessageWithText(text: "무한한 공간 저너머로", friend: woody, minuteAgo: 0, context: context, isSender: true)
        createMessageWithText(text: "내 부츠에 뱀이 들어있다", friend: woody, minuteAgo: 15, context: context)
        
        let cat = createFriend(name: "냥냥이", profileImg: "sampleImg2", context: context)
        createMessageWithText(text: "멍멍멍 멍멍 멍~멍멍멍", friend: cat, minuteAgo: 27*60, context: context, isSender: true)
        createMessageWithText(text: "왈왈 와르를으릉", friend: cat,  minuteAgo: 25*60, context: context, isSender: true)
        createMessageWithText(text: "냐옹 냐옹 냐옹 냐아아옹", friend: cat,  minuteAgo: 26*60, context: context)
        createMessageWithText(text: "아우우우우 아우우우", friend: cat, minuteAgo: 28*60, context: context, isSender: true)
        createMessageWithText(text: "미야오옹 미야오옹", friend: cat,  minuteAgo: 25*60, context: context)
        createMessageWithText(text: "모우우우웅", friend: cat,  minuteAgo: 30*60, context: context)
        
        let rex = createFriend(name: "댕청한 공룡", profileImg: "rex", context: context)
        createMessageWithText(text: "너는 댕청한 공룡이냐 멍청한 공룡이냐", friend: rex, minuteAgo: 7*24*60, context: context, isSender: true)
        createMessageWithText(text: "나는 댕청 멍청한 공룡이지", friend: rex, minuteAgo: 10, context: context)
        do {
            try(context.save())
        }
        catch let err{
            print(err.localizedDescription)
        }
        
        //messages = [messageWoody, messageCat]
        loadData()
    }
    
    
    func createFriend(name: String, profileImg: String, context: NSManagedObjectContext) -> Friend{
        let friend = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        friend.name = name
        friend.profileImg = profileImg
        
        return friend
    }
    
    func createMessageWithText(text: String, friend: Friend, minuteAgo: Double, context: NSManagedObjectContext, isSender:Bool = false)
    {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.text = text
        message.date = NSDate().addingTimeInterval(-minuteAgo * 60)
        message.friend = friend
        message.isSender = isSender
    }
    
    func loadData() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = delegate.persistentContainer.viewContext
        
        if let friends = fetchFriends()
        {
            messages = [Message]()
            for friend in friends {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
                fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                fetchRequest.fetchLimit = 1
                do{
                    let result = try context.fetch(fetchRequest)
                    for data in result as! [NSManagedObject] {
                        messages!.append(data as! Message)
                    }
                }
                catch let err{
                    print(err.localizedDescription)
                }
            }
            messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})
        }
    }
    
    private func fetchFriends() -> [Friend]?
    {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return nil}
        let context = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
        do{
            let result = try context.fetch(fetchRequest) as! [Friend]
            return result
        }
        catch let err{
            print(err.localizedDescription)
        }
        
        return nil
    }
    
    func clearData()
    {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = delegate.persistentContainer.viewContext
        do{
            let entityNames = ["Friend", "Message"]
            for entityName in entityNames
            {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                let result = try context.fetch(fetchRequest)
                for data in result as! [NSManagedObject] {
                    context.delete(data)
                }
            }
            try context.save()
        }
        catch let err{
            print(err.localizedDescription)
        }
    }
    
}
