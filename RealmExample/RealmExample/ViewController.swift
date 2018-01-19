//
//  ViewController.swift
//  RealmExample
//
//  Created by 이광용 on 2018. 1. 15..
//  Copyright © 2018년 이광용. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class Dog: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    let owners = LinkingObjects(fromType: Person.self, property: "dogs")
}
class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var picture: Data? = nil // optionals supported
    let dogs = List<Dog>()
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Use them like regular Swift objects
        let myDog = Dog()
        myDog.name = "Cocos"
        myDog.age = 5
        print("name of dog: \(myDog.name)")

        // Get the default Realm
        let realm = try! Realm()

        // Query Realm for all dogs less than 2 years old
        let puppies = realm.objects(Dog.self).filter("age > 2")
        print(puppies.count) // => 0 because no dogs have been added to the Realm yet

        // Persist your data easily
        try! realm.write {
            realm.add(myDog)
        }

        
//         Queries are updated in realtime
        print(puppies.count) // => 1
        let person = Person()
        person.name = "GwangGro"
        person.picture = nil
        person.dogs.append(myDog)
        try! realm.write {
            realm.add(person)
        }
        
        
        // Query and update from any thread
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let theDog = realm.objects(Dog.self).filter("age == 1").first
                try! realm.write {
                    theDog!.age = 3
                }
            }
        }
        
        let folderPath = realm.configuration.fileURL!.deletingLastPathComponent().path
        print(folderPath)
        
//        let rex = realm.objects(Dog.self).filter("name contains 'Rex'")
//        try! realm.write {
//            realm.delete(rex)
//        }
        
        let cocos = realm.objects(Dog.self).filter("name contains 'Cocos'")
        print(cocos.map({ (dog) -> Dog in
            print(dog.owners)
            return dog
        }) )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

