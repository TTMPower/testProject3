//
//  PersistanceForToDo.swift
//  projectHomeWork
//
//  Created by Владислав Вишняков on 21.06.2021.
//

import Foundation
import RealmSwift

//MARK: Model for part b) (textfield + textfield)

class Tasks: Object {
    @objc dynamic var text = ""
    @objc dynamic var completed = false
    
}
