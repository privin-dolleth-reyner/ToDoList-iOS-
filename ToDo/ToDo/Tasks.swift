//
//  Tasks.swift
//  ToDo
//
//  Created by Ahamed Muqthar M K on 12/03/17.
//  Copyright © 2017 Privin. All rights reserved.
//

import Foundation
import RealmSwift

class Tasks: Object {
    dynamic var taskId = 0
    dynamic var text = ""
    dynamic var completed = false
    
    override static func primaryKey() -> String? {
        return "taskId"
    }
}
