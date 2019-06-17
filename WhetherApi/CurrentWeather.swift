//
//  CurrentWeather.swift
//  WhetherApi
//
//  Created by Михаил on 14/06/2019.
//  Copyright © 2019 Михаил. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature: Double
    let apparentTemperature: Double
    let humidity: Double
    let pressure: Double
    let icon: UIImage
    let summary: String
    let hourlySummary: String
}



extension CurrentWeather: JSONDecodable {
    init?(JSON: [String: AnyObject]) {
        guard let temperature = JSON["temperature"] as? Double,
        let apparentTemperature = JSON["apparentTemperature"] as? Double,
        let humidity = JSON["humidity"] as? Double,
        let summary = JSON["summary"] as? String,
        let hourlySummary = JSON["summary"] as? String,
        let pressure = JSON["pressure"] as? Double,
        let iconString = JSON["icon"] as? String else {
                return nil
        }
        let icon = WeatherIconManager(rawValue: iconString).image
        
        self.temperature = temperature
        self.apparentTemperature = apparentTemperature
        self.humidity = humidity
        self.pressure = pressure
        self.summary = summary
        self.hourlySummary = hourlySummary
        self.icon = icon
        
    }
}
extension CurrentWeather {
    var pressureString: String {
        return "\(Int(pressure * 0.750062)) mm"
    }
    var humidityString: String {
        return "\(Int(humidity * 100)) %"
    }
    var temperatureString: String {
        return "\(Int((temperature)))˚C"
    }
    var appearentTemperatureString: String {
        return "Feels like: \(Int((apparentTemperature)))˚C"
    }
}
