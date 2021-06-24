//
//  WeatherModel.swift
//  projectHomeWork
//
//  Created by Владислав Вишняков on 22.06.2021.
//

import Foundation
import RealmSwift

struct API {
    static var URLCurrent = "https://api.openweathermap.org/data/2.5/weather"
    static var URLForecast = "https://api.openweathermap.org/data/2.5/forecast"
    static var URLToken = "?q=Moscow&units=metric&appid=90f8ee67bd11a69a3cad7a0b467cf053"
}

class WeatherAPI: Codable  {
    var main: MainStruct?
    var name: String = ""
    var cod: Int
}

class MainStruct: Codable  {
    var temp: Double = 0.0
    
}

class RealmWeather: Object {
    @objc dynamic var name = ""
    @objc dynamic var temp = 0.0
}
