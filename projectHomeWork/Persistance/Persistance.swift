//
//  Persistance.swift
//  projectHomeWork
//
//  Created by Владислав Вишняков on 21.06.2021.
//

import Foundation

//MARK: Model for part a) (textfield + textfield)

class Persistance {
    static let shared = Persistance()
    private let firstNameKey = "firstKeyData"
    private let secondNameKey = "secondKeyData"
    
    var firstName: String? {
        set { UserDefaults.standard.set(newValue, forKey: firstNameKey) }
        get { return UserDefaults.standard.string(forKey: firstNameKey) }
    }
    var secondName: String? {
        set { UserDefaults.standard.set(newValue, forKey: secondNameKey) }
        get { return UserDefaults.standard.string(forKey: secondNameKey) }
    }
}
