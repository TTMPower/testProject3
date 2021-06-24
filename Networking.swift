//
//  Networking.swift
//  projectHomeWork
//
//  Created by Владислав Вишняков on 22.06.2021.
//

import Foundation
import RealmSwift

class Networking {
    
    var realmWeather = try! Realm()
    var forecastRealmWeather = try! Realm()
    var forecastRealmDate = try! Realm()
    
    func getDataWeather(url: String, params: String, complition: @escaping (WeatherAPI) -> Void) {
        let urlMain = URL(string: url + params)
        var request = URLRequest(url: urlMain!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            if error != nil {
                print(error.debugDescription)
                return
            } else if data != nil {
                do {
                    let myData = try JSONDecoder().decode(WeatherAPI.self, from: data!)
                    complition(myData)
                    getWeatherData(data: myData)
                    
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getForecasturl(url: URL ,complition: @escaping (ForecastModel) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            if error != nil {
                print(error.debugDescription)
                return
            } else if data != nil {
                do {
                    let myData = try JSONDecoder().decode(ForecastModel.self, from: data!)
                    complition(myData)
                    if myData.list != nil {
                        getForecastData(date: myData.list!)
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func getForecastData(date: [ListForecast]) {
        DispatchQueue.main.async {
            do {
                try self.forecastRealmWeather.write {
                    let filtredData = date.filter { ($0.dtTxt.contains("12:00:00")) }
                    let forecastData = ForecastRealm()
                    for el in filtredData {
                        forecastData.temp.append(el.main!.temp)
                        forecastData.dtTxt.append(el.dtTxt)
                    }
                    self.forecastRealmDate.add(forecastData)
                    print(forecastData.dtTxt)
                    print(forecastData.temp)
                    
                }
                
            } catch {
                print("error saving TEMPERATURE")
            }
        }
    }
    
    func getWeatherData(data: WeatherAPI) {
        DispatchQueue.main.async {
            do {
                try self.realmWeather.write {
                    let newData = RealmWeather()
                    newData.temp = data.main!.temp
                    newData.name = data.name
                    self.realmWeather.add(newData)
                    print("Data SAVED: \(newData.name) //// \(newData.temp)")
                }
            } catch {
                print("error saving WEATHER MAIN")
            }
        }
    }
}
