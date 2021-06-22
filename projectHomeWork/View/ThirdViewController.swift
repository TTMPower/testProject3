//
//  ThirdViewController.swift
//  projectHomeWork
//
//  Created by Владислав Вишняков on 22.06.2021.
//

//MARK: Задача
// Тоже самое что и Realm только используя CoreData


import UIKit
import CoreData

class ThirdViewController: UIViewController, UITableViewDelegate {
    var arrayInfo = CoreData.shared
    
    //MARK: Button for add new task and save data in CoreData
    @IBAction func addNewObjectButton(_ sender: Any) {
        //Alert view
        let alertAction = UIAlertController(title: "Новая задача", message: "Введите текст", preferredStyle: .alert)
        
        let saveData = UIAlertAction(title: "Сохранить", style: .default) { action in
            let text = alertAction.textFields?.first
            if let newText = text?.text {
                /// Save Core Data
                self.arrayInfo.saveData(title: newText)
                self.thirdTableView.reloadData()
            }
        }
        alertAction.addTextField { _ in }
        let cancleAction = UIAlertAction(title: "Отмена", style: .default) { _ in }
        alertAction.addAction(saveData)
        alertAction.addAction(cancleAction)
        present(alertAction, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var thirdTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arrayInfo.coreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thirdTableView.delegate = self
        thirdTableView.dataSource = self
    }
}

extension ThirdViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayInfo.arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "thirdcell", for: indexPath)
        
        let textInRow = arrayInfo.arrayData[indexPath.row]
        cell.textLabel?.text = textInRow.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let editingRow = arrayInfo.arrayData[indexPath.row]
        
        //MARK: Swipe left for delete task from tableview and CoreData
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(editingRow)
            arrayInfo.arrayData.remove(at: indexPath.row)
            do {
                try context.save()
            } catch _ {
            }
            self.thirdTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
