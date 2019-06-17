//
//  HourlyWeather.swift
//  WhetherApi
//
//  Created by Михаил on 16/06/2019.
//  Copyright © 2019 Михаил. All rights reserved.
//          hourlySummary

import Foundation
import UIKit

struct HourlyWeather {
    let summary: String
    let icon: UIImage
}

extension HourlyWeather: JSONDecodable {
    init?(JSON: [String: AnyObject]) {
        guard
            let summary = JSON["summary"] as? String,
            let iconString = JSON["icon"] as? String else {
                return nil
        }
        let icon = WeatherIconManager(rawValue: iconString).image
        
        self.summary = summary
        self.icon = icon
    }
}

