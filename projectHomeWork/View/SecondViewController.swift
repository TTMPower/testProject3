//
//  SecondViewController.swift
//  projectHomeWork
//
//  Created by Владислав Вишняков on 21.06.2021.
//

import UIKit
import RealmSwift

//MARK: Список Todo с возможностью добавления и удаления задач, в котором задачи кешируются в Realm, а при повторном запуске показываются последние сохранённые задачи.

class SecondViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var arrayRealm = Tasks()
    
    @IBAction func addTask(_ sender: Any) {
        let alertAction = UIAlertController(title: "Новая задача", message: "Введите текст", preferredStyle: .alert)
        let saveData = UIAlertAction(title: "Сохранить", style: .default) { [self] action in
            let tf = alertAction.textFields?.first
            if let newTask = tf?.text {
                self.arrayRealm.text.insert(newTask, at: 0)
                PersistanceToDo.shared.testTask(string: newTask)
                self.tableView.reloadData()
                
                
            }
        }
        alertAction.addTextField { _ in }
        let cancleAction = UIAlertAction(title: "Отмена", style: .default) { _ in }
        alertAction.addAction(saveData)
        alertAction.addAction(cancleAction)
        
        present(alertAction, animated: true, completion: nil)
    }
    
    let realm = try! Realm()
    var DataText: Results<Tasks> {
            get {
                return realm.objects(Tasks.self)
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print(realm.objects(Tasks.self))
    }
    
    
}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRealm.text.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let lists = arrayRealm.text[indexPath.row]
        let lists = DataText[indexPath.item].text
        cell.textLabel?.text = lists[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        arrayRealm.text.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
