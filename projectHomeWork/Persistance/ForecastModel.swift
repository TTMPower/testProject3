//
//  ForecastModel.swift
//  projectHomeWork
//
//  Created by Владислав Вишняков on 22.06.2021.
//

import Foundation
import RealmSwift

class ForecastModel: Codable {
    var cod: String?
    var list: [ListForecast]?
    var city: CityForecast?

    enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case list = "list"
        case city = "city"
    }
}

class CityForecast: Codable {
    var name: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
}
}

class ListForecast: Object, Codable {
    @objc dynamic var dt: Int
    dynamic var main: MainClassForecast?
    @objc dynamic var dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case main = "main"
        case dtTxt = "dt_txt"
    }
}

class MainClassForecast: Object, Codable {
    @objc dynamic var temp: Double
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
    }
}


class ForecastRealm: Object {
    dynamic var dtTxt = List<String>()
    dynamic var temp = List<Double>()
}
