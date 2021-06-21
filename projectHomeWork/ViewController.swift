//
//  ViewController.swift
//  projectHomeWork
//
//  Created by Владислав Вишняков on 21.06.2021.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var secondName: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstName.text = Persistance.shared.firstName
        secondName.text = Persistance.shared.secondName
        
       

    }
    
    @IBAction func saveButton(_ sender: Any) {
        Persistance.shared.firstName = firstName.text
        Persistance.shared.secondName = secondName.text
        print(Persistance.shared.firstName)
        print(Persistance.shared.secondName)
    }


}

