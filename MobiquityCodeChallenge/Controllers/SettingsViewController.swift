//
//  SettingsViewController.swift
//  MobiquityCodeChallenge
//
//  Created by Apple on 27/02/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var unitsButton: UIButton!
    @IBOutlet weak var dateFormatButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        unitsButton.setTitle(SettingsDataController.shared.selectedUnit.rawValue, for: .normal)
        dateFormatButton.setTitle(SettingsDataController.shared.selectedDateFormat.rawValue, for: .normal)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dateFormatAction(_ sender: Any) {
        showDateFormatAction()
    }
    
    
    @IBAction func metricAction(_ sender: Any) {
        showUnitsAction()
    }
    
    @IBAction func resetBookMarkCities(_ sender: Any) {
        showResetBookMarkCitiesAlert()
    }
    
    func showUnitsAction()  {
        let optionMenu = UIAlertController(title: "Choose Your Option", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let option1 = UIAlertAction(title: Units.metric.rawValue, style: .default, handler: {(alert: UIAlertAction!) -> Void in
            self.unitsButton.setTitle(Units.metric.rawValue, for: .normal)
            SettingsDataController.shared.saveUnitSettings(unit: Units.metric)
        })
        
        let option2 = UIAlertAction(title: Units.imperial.rawValue, style: .default, handler: {(alert: UIAlertAction!) -> Void in
            self.unitsButton.setTitle(Units.imperial.rawValue, for: .normal)
            SettingsDataController.shared.saveUnitSettings(unit: Units.imperial)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) -> Void in
            
        })
        
        optionMenu.addAction(option1)
        optionMenu.addAction(option2)
        optionMenu.addAction(cancelAction)
        
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad )
        {
            if let currentPopoverpresentioncontroller = optionMenu.popoverPresentationController{
                currentPopoverpresentioncontroller.sourceView = unitsButton
                currentPopoverpresentioncontroller.sourceRect = unitsButton.bounds;
                currentPopoverpresentioncontroller.permittedArrowDirections = UIPopoverArrowDirection.up;
                self.present(optionMenu, animated: true, completion: nil)
            }
        }else{
            self.present(optionMenu, animated: true, completion: nil)
        }
        
    }
    
    func showDateFormatAction()  {
        let optionMenu = UIAlertController(title: "Choose Your Option", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let option1 = UIAlertAction(title: DateFormats.format1.rawValue, style: .default, handler: {(alert: UIAlertAction!) -> Void in
            self.dateFormatButton.setTitle(DateFormats.format1.rawValue, for: .normal)
            SettingsDataController.shared.saveDateFormatSettings(dateFormat: DateFormats.format1)
        })
        
        let option2 = UIAlertAction(title: DateFormats.format2.rawValue, style: .default, handler: {(alert: UIAlertAction!) -> Void in
            self.dateFormatButton.setTitle(DateFormats.format2.rawValue, for: .normal)
            SettingsDataController.shared.saveDateFormatSettings(dateFormat: DateFormats.format2)
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(alert: UIAlertAction!) -> Void in
            
        })
        
        optionMenu.addAction(option1)
        optionMenu.addAction(option2)
        optionMenu.addAction(cancelAction)
        
        
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad )
        {
            if let currentPopoverpresentioncontroller = optionMenu.popoverPresentationController{
                currentPopoverpresentioncontroller.sourceView = dateFormatButton
                currentPopoverpresentioncontroller.sourceRect = dateFormatButton.bounds;
                currentPopoverpresentioncontroller.permittedArrowDirections = UIPopoverArrowDirection.up;
                self.present(optionMenu, animated: true, completion: nil)
            }
        }else{
            self.present(optionMenu, animated: true, completion: nil)
        }
    }
    func showResetBookMarkCitiesAlert()  {
        // create the alert
        let alert = UIAlertController(title: "Reset Bookmark cities", message: "Would you like to remove saved bookmark cities ?", preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            
            FavouriteLocationsDataController.shared.removeAllLocations()
            
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}
