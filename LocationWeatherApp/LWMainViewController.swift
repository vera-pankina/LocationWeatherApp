//
//  ViewController.swift
//  Metaweather
//
//  Created by vpankina on 01/12/2019.
//  Copyright © 2019 vpankina. All rights reserved.
//

import UIKit
import LocationWeatherFramework

class LWMainViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private var location: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addCloseKeyboardTap()
        needShowActivityIndicator(false)
    }
    
    private func addCloseKeyboardTap() {
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(closeTap)
    }
    
    @objc private func closeKeyboard() {
        if locationTextField.isFirstResponder {
            locationTextField.resignFirstResponder()
        }
    }
    
    private func getWeather(for location: String?) {
        if checkLocation(location) {
            needShowActivityIndicator(true)
            if let location = self.location {
                let cuncurrentQueue = DispatchQueue(label: "Weather", qos: .userInitiated, attributes: .concurrent)
                cuncurrentQueue.async { [weak self] in
                    LWWeatherManager.shared.getWeather(location: location) {
                        [weak self] (weather, error) in
                        guard let self = self else { return }
                        let mainQueue = DispatchQueue.main
                        mainQueue.async { [weak self] in
                            guard let self = self else { return }
                            self.needShowActivityIndicator(false)
                            self.showNotificationAlert(weather: weather, error: error)
                        }
                    }
                }
                
            }
        } else {
            print("Ошибка в локации: %@", location ?? "")
        }
        
    }
    
    private func checkLocation(_ location: String?) -> Bool {
        if var location = location, !location.isEmpty {
            location = location.trimmingCharacters(in: CharacterSet.init(charactersIn: " "))
            self.location = location
            return true
        }
        showNotificationAlert(weather: nil, error: "Необходимо ввести локацию")
        return false
    }
    
    private func showNotificationAlert(weather: LWWeatherModel?, error: String?) {
        var title = "Ошибка"
        var message = "Что-то пошло не так..."
        if let weather = weather {
            title = "Погода в локации: " + (self.location ?? "")
            message = getWeatherMessage(weather: weather)
        } else if let error = error {
            message = error
        }
        
        let resultAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        resultAlert.addAction(actionOk)
        show(resultAlert, sender: self)
    }
    
    private func getWeatherMessage(weather: LWWeatherModel) -> String {
        var message = ""
        if let weather_state_name = weather.weather_state_name {
            message += "Ожидается: " + weather_state_name + "\n"
        }
        if let min_temp = weather.min_temp {
            message += "Минимальная температура: " + String(Int(min_temp)) + "\n"
        }
        if let max_temp = weather.max_temp {
            message += "Максимальная температура: " + String(Int(max_temp)) + "\n"
        }
        if let the_temp = weather.the_temp {
            message += " Температура: " + String(Int(the_temp)) + "\n"
        }
        if let wind_speed = weather.wind_speed {
            message += " Скорость ветра: " + String(Int(wind_speed)) + "\n"
        }
        if let wind_direction = weather.wind_direction {
            message += " Направление ветра: " + String(Int(wind_direction)) + "\n"
        }
        return message
    }
    
    private func needShowActivityIndicator(_ needShow: Bool) {
        activityIndicator.isHidden = !needShow
        if needShow {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

extension LWMainViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getWeather(for:textField.text)
        return true
    }
}

