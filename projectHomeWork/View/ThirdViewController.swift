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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func editTask(item: DataTasks, newString: String) {
        item.title = newString
        do {
            try context.save()
            arrayInfo.coreData()
        }
        catch {
            
        }
    }
    
    //MARK: Button for add new task and save data in CoreData
    @IBAction func addNewObjectButton(_ sender: Any) {
        //Alert view
        let alertAction = UIAlertController(title: "Новая задача", message: "Введите текст", preferredStyle: .alert)
        
        let saveData = UIAlertAction(title: "Сохранить", style: .default) { action in
            let text = alertAction.textFields?.first
            if let newText = text?.text {
                /// Save Core Data
                self.arrayInfo.saveData(title: newText, alpha: 0.2)
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
    //MARK: edit / checkmark alert
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = arrayInfo.arrayData[indexPath.row]
        let alertAction = UIAlertController(title: "Изменить", message: nil, preferredStyle: .actionSheet)
        alertAction.addAction(UIAlertAction(title: "Отмена", style: .destructive, handler: { _ in
            
        }))
        alertAction.addAction(UIAlertAction(title: "Изменить", style: .default, handler: {_ in
            let alert = UIAlertController(title: "Новый текст", message: nil, preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.title
            alert.addAction(UIAlertAction(title: "Сохранить", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                    return
                }
                self?.editTask(item: item, newString: text)

                tableView.reloadData()
            }))
            self.present(alert, animated: true)
            
        }))
        
        alertAction.addAction(UIAlertAction(title: "Checkmark", style: .default, handler: {_ in
            let newA = self.arrayInfo.arrayData[indexPath.row]
            newA.alpha = 1
            try! self.context.save()
            tableView.reloadData()
        }))
        present(alertAction, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayInfo.arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "thirdcell", for: indexPath) as! CoreDataTableViewCell
        let textInRow = arrayInfo.arrayData[indexPath.row]
        cell.checkMark.alpha = CGFloat(textInRow.alpha)
        cell.labelCellCore.text = textInRow.title
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
