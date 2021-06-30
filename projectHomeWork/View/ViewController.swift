//
//  ViewController.swift
//  projectHomeWork
//
//  Created by Владислав Вишняков on 21.06.2021.
//

// MARK: Два текстовых поля для имени и фамилии, которые сохраняют введённые данные в UserDefaults, а при повторном запуске приложения показывают последние введённые строки;

import UIKit

class ViewController: UIViewController {

 

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var secondName: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.text = Persistance.shared.firstName
        secondName.text = Persistance.shared.secondName
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        Persistance.shared.firstName = firstName.text
        Persistance.shared.secondName = secondName.text
    }


}

