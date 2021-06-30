//
//  DataTasks+CoreDataProperties.swift
//  
//
//  Created by Владислав Вишняков on 30.06.2021.
//
//

import Foundation
import CoreData


extension DataTasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataTasks> {
        return NSFetchRequest<DataTasks>(entityName: "DataTasks")
    }

    @NSManaged public var title: String?

}
