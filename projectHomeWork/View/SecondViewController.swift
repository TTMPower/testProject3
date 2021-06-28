//
//  SecondViewController.swift
//  projectHomeWork
//
//  Created by Владислав Вишняков on 21.06.2021.
//

import UIKit

//MARK: Список Todo с возможностью добавления и удаления задач, в котором задачи кешируются в Realm, а при повторном запуске показываются последние сохранённые задачи.

class SecondViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let network = Networking.networksingletop
    
    
    //MARK: Add new note
    @IBAction func addTask(_ sender: Any) {
        let alertAction = UIAlertController(title: "Новая задача", message: "Введите текст", preferredStyle: .alert)
        let saveData = UIAlertAction(title: "Сохранить", style: .default) { [self] action in
            guard let text = alertAction.textFields?.first?.text, !text.isEmpty else { return }
            let task = Tasks()
            task.text = text
            try! self.network.realm.write {
                self.network.realm.add(task)
                self.tableView.reloadData()
            }
        }
        alertAction.addTextField { _ in }
        let cancleAction = UIAlertAction(title: "Отмена", style: .default) { _ in }
        alertAction.addAction(saveData)
        alertAction.addAction(cancleAction)
        present(alertAction, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        network.arrayString = network.realm.objects(Tasks.self)
    }
    
    
}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if network.arrayString.count != 0{
            return network.arrayString.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let listes = network.arrayString[indexPath.row]
        cell.textLabel?.text = listes.text
        return cell
    }
    
    // MARK: Delete row from left swipe
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let editingRow = network.arrayString[indexPath.row]
        if editingStyle == .delete {
            try! self.network.realm.write {
                self.network.realm.delete(editingRow)
                tableView.reloadData()
            }
        }
    }
}
