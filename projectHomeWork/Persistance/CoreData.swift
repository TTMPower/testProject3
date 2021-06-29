//
//  CoreData.swift
//  projectHomeWork
//
//  Created by Владислав Вишняков on 22.06.2021.
//

import Foundation
import CoreData
import UIKit

class CoreData {
    
    static let shared = CoreData()
    var arrayData: [DataTasks] = []
    
    //MARK: fetchRequest
    
    func coreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchReques: NSFetchRequest<DataTasks> = DataTasks.fetchRequest()
        
        do {
            arrayData = try context.fetch(fetchReques)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    //MARK: Save CoreData object
    
    func saveData(title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "DataTasks", in: context) else { return }
        let taskObject = DataTasks(entity: entity, insertInto: context)
        taskObject.title = title
        do {
            try context.save()
            arrayData.append(taskObject)
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
}
