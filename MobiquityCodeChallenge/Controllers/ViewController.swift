//
//  ViewController.swift
//  MobiquityCodeChallenge
//
//  Created by Viswanath Reddy on 27/02/21.
//

import UIKit

class ViewController: UIViewController,UISearchResultsUpdating {
    
    @IBOutlet weak var tableview: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var filteredLocations = [FavouriteLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationItems()
        setupSearchController()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filteredLocations = FavouriteLocationsDataController.shared.locations
        tableview.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        searchController.searchBar.text = ""
        //        searchController.isActive = false
        
        // searchController.dismiss(animated: false, completion: nil)
    }
    
    func setUpNavigationItems()  {
       
        self.title = "Favourite Locations"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "location"), style: .plain, target: self, action: #selector(mapViewAction))
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(settingsAction)),  UIBarButtonItem(title: "HELP", style: .done, target: self, action: #selector(helpButtonTapped))]
        
    }
    
    
    func setupSearchController() {
        searchController.searchBar.placeholder = "Type something here to search"
        searchController.searchBar.sizeToFit()
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        self.tableview.tableHeaderView = searchController.searchBar
        
    }
    
    @objc func mapViewAction() {
      
        guard let lsController = self.storyboard?.instantiateViewController(withIdentifier: "LocationSelectionViewController") as? LocationSelectionViewController else {
            return
        }
        self.navigationController?.pushViewController(lsController, animated: true)
    }
    
    @objc func settingsAction() {
       
        guard let settings = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else {
            return
        }
        self.navigationController?.pushViewController(settings, animated: true)
    }
    
    @objc func helpButtonTapped() {
       
        guard let helpVC = self.storyboard?.instantiateViewController(withIdentifier: "HelpViewController") as? HelpViewController else {
            return
        }
        self.navigationController?.pushViewController(helpVC, animated: true)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredLocations = FavouriteLocationsDataController.shared.locations.filter { location in
                return location.city.lowercased().starts(with:searchText.lowercased())
            }
            
        } else {
            filteredLocations = FavouriteLocationsDataController.shared.locations
        }
        tableview.reloadData()
    }
    
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteredLocations.count == 0 {
            tableView.setEmptyMessage("No favourites locations")
        } else {
            tableView.restore()
        }
        
        return filteredLocations.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "fcell")
        
        let object = filteredLocations[indexPath.row]
        cell.textLabel?.text = object.city
        cell.detailTextLabel?.text = object.country
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            let locationToDelete = filteredLocations[indexPath.row];
            FavouriteLocationsDataController.shared.removeLocation(location: locationToDelete)
            deleteLocationFromFilterArray(location: locationToDelete)
            tableView.reloadData()
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Move to Location area
        moveToWeatherDetail(indexpath: indexPath)
        
    }
    
    func deleteLocationFromFilterArray(location: FavouriteLocation)  {  // To delete location from filtered array
        if let indexOfLocation = filteredLocations.firstIndex(where: { $0.latitude == location.latitude && $0.longitude == location.longitude}){
            filteredLocations.remove(at: indexOfLocation)
        }
    }
    
    func moveToWeatherDetail(indexpath: IndexPath)  {
        
        guard let weatherDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "WeatherDetailsViewController") as? WeatherDetailsViewController else {
            return
        }
        weatherDetailVC.selectedLocation = filteredLocations[indexpath.row]
        self.navigationController?.pushViewController(weatherDetailVC, animated: true)
        
    }
}


