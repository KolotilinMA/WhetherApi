//
//  ViewController.swift
//  WhetherApi
//
//  Created by Михаил on 14/06/2019.
//  Copyright © 2019 Михаил. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var locatinLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var hourlySummaryLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearentTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let locationManager = CLLocationManager()
    var place: String = String()
    var locationLatitude: Double = 0.0
    var locationLongitude: Double = 0.0
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        toggleActivityIndicator(on: true)
        getCurrentWeatherData()
    }
    
    func toggleActivityIndicator(on: Bool) {
        refreshButton.isHidden = on
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    lazy var weatherManager = APIWeatherManager(apiKey: "35e16dbbb809075c0eb38d4d070d72c2")
    let coordinates = Coordinates(latitude: 55.755786, longitude: 37.617633)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        place = decoder()
        getCurrentWeatherData()
        
        print("\(String(describing: getCurrentWeatherData))")
    
        locatinLabel.text = place
        
        print("Распечатка адреса")
        print("Адрес: \(place)")
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last! as CLLocation
        
        print("my location latitude: \(userLocation.coordinate.latitude), longitude: \(userLocation.coordinate.longitude)")
        locationLatitude = userLocation.coordinate.latitude
        locationLongitude = userLocation.coordinate.longitude
    }
    
    
    func getCurrentWeatherData() {
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
            self.toggleActivityIndicator(on: false)
            switch result {
            case .Success(let currentWeather):
                self.updateUIWith(currentWeather: currentWeather)
            case .Failure(let error as NSError):
                let alertController = UIAlertController(title: "Unable to get data", message: "\(error.localizedDescription)", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            default: break
            }
        }
    }
    
    func updateUIWith(currentWeather: CurrentWeather) {
        self.imageView.image = currentWeather.icon
        self.summaryLabel.text = currentWeather.summary
        self.pressureLabel.text = currentWeather.pressureString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.appearentTemperatureLabel.text = currentWeather.appearentTemperatureString
        self.humidityLabel.text = currentWeather.humidityString
        
    }
    
    func decoder() -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: 55.755786, longitude: 37.617633)
        var adress = ""
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if let city = placeMark.addressDictionary!["City"] as? NSString {
                adress = city as String
                print("Адрес: \(adress)")
            }
            if let country = placeMark.addressDictionary!["Country"] as? NSString {
                adress = adress + ", " + (country as String)
                print("Адрес: \(adress)")
                self.place = adress
            }
        })
        self.place = adress
        print("Распечатка адреса")
        print("Адрес: \(place)")
        print("Адрес: \(adress)")
        return adress
    }
    
    
}




