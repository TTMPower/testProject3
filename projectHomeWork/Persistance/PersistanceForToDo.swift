//
//  PersistanceForToDo.swift
//  projectHomeWork
//
//  Created by Владислав Вишняков on 21.06.2021.
//

import Foundation
import RealmSwift

class Tasks: Object {
    var text = List<String>()
}


class PersistanceToDo {
    static let shared = PersistanceToDo()
    private let realm = try! Realm()
    func testTask(string: String) {
        let task = Tasks()
        task.text.append(string)
        try! realm.write {
            realm.add(task)
        }
        let allTasks = realm.objects(Tasks.self)
    }
    
}
