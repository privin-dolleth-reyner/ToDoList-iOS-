//
//  DataBase.swift
//  ToDo
//
//  Created by Ahamed Muqthar M K on 14/03/17.
//  Copyright © 2017 Privin. All rights reserved.
//

import Foundation
import RealmSwift

public class DataBase {
    
    let realm : Realm = {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                }
        })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        return try! Realm()
    }()
    
    
    func getRealmInstance() -> Realm{
        return realm
    }
    
    func addTask(task : Tasks) {
        try! realm.write {
            realm.add(task)
        }
        
    }
    
    func updateTask(task : Tasks) {
        try! realm.write {
            realm.add(task,update: true)
        }
    }
    
    func delete(task : Tasks){
        try! realm.write {
            realm.delete(task)
        }
    }
    
    func deleteAll(){
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    
}
