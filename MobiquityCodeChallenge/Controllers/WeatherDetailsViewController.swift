//
//  WeatherDetailsViewController.swift
//  MobiquityCodeChallenge
//
//  Created by Apple on 27/02/21.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    @IBOutlet weak var temparatureValueLabel: UILabel!
    
    @IBOutlet weak var humadityValueLabel: UILabel!
    
    @IBOutlet weak var rainChancesValueLabel: UILabel!
    
    @IBOutlet weak var windSpeedValueLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var forecastWeatherList = [WeatherList]()
    
    let reuseIdentifier = "forecastCell"
    
    var selectedLocation: FavouriteLocation? = nil
    private var weatherViewModel : WeatherViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let location = selectedLocation {
            self.title = location.city
        }
        else {
            self.title = "Weather report"
        }
        setCollectionViewFlowLayout()
        callToViewModelForUIUpdate()
        
        
        // Do any additional setup after loading the view.
    }
    
    func setCollectionViewFlowLayout()  {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
               layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
               let screenWidth = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: screenWidth/2.2, height: screenWidth/2)
               layout.minimumInteritemSpacing = 0
               layout.minimumLineSpacing = 10
               collectionView!.collectionViewLayout = layout
        
    }
    
    func callToViewModelForUIUpdate(){
        
        self.weatherViewModel =  WeatherViewModel()
        
        guard let selectedLoc = selectedLocation else {
            return
        }
        // for Current weather information
        self.weatherViewModel.callFuncToGetCuurentWeatherData(location: selectedLoc)
        self.weatherViewModel.bindWeatherViewModelToController = {
            
            DispatchQueue.main.async {
                if let temparature = self.weatherViewModel.weatherInfo.main?.temp{
                    self.temparatureValueLabel.text = String(temparature)  + SettingsDataController.shared.getUnitsForTemparature()
                    
                }
                if let wind = self.weatherViewModel.weatherInfo.wind?.speed{
                    self.windSpeedValueLabel.text = String(wind) + SettingsDataController.shared.getUnitsForWind()
                }
                if let humadity = self.weatherViewModel.weatherInfo.main?.humidity{
                    self.humadityValueLabel.text = String(humadity) + SettingsDataController.shared.getUnitsForHumidity()
                }
                
                self.rainChancesValueLabel.text = "N/A"
            }
            
        }
        
      
        // For Forecast weather information
        self.weatherViewModel.callFuncToGetForecastWeatherData(location: selectedLoc)
        self.weatherViewModel.bindForecastWeatherViewModelToController = {

            guard let forecaseWeatherList = self.weatherViewModel.forecastWeatherInfo.list else {
                return
            }
            self.forecastWeatherList = forecaseWeatherList
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }

}

extension WeatherDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastWeatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ForecastCollectionViewCell
        
        let weatherObj = forecastWeatherList[indexPath.row]
        
        cell.dateValueLabel.text = SettingsDataController.shared.getFormattedDate(timeStamp: weatherObj.dt)
        cell.temparatureValueLabel.text = String(weatherObj.main.temp) + SettingsDataController.shared.getUnitsForTemparature()
        cell.windSpeedValueLabel.text =  String(weatherObj.wind.speed) + SettingsDataController.shared.getUnitsForWind()
        cell.humadityValueLabel.text =    String(weatherObj.main.humidity) + SettingsDataController.shared.getUnitsForHumidity()
        cell.rainChancesValueLabel.text =  String(weatherObj.pop) + SettingsDataController.shared.getUnitsForRainChances()
        
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        
        return cell
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }

}
