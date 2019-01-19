//
//  SettingsViewController.swift
//  Clock
//
//  Created by Joseph Yuen on 8/2/18.
//  Copyright © 2018 Joseph Yuen. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var timeSettingLbl: UILabel!
    @IBOutlet weak var themeSettingLbl: UILabel!
    @IBOutlet weak var twentyfourBtn: UIButton!
    @IBOutlet weak var twelveBtn: UIButton!
    @IBOutlet weak var whiteBtn: UIButton!
    @IBOutlet weak var blackBtn: UIButton!
    @IBOutlet weak var informationBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var offDateBtn: UIButton!
    @IBOutlet weak var onDateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Retrieve Saved Data
        dateGV = UserDefaults.standard.integer(forKey: "dateGV")
        timeGV = UserDefaults.standard.integer(forKey: "timeGV")
        themeGV = UserDefaults.standard.integer(forKey: "themeGV")
        
        setTheme(theme: themeGV)
        
    }

    func setTheme(theme:Int) {
        
        switch theme {
        case 0: // white
            if (timeGV == 0) { // if 24HR
                twentyfourBtn.backgroundColor = steel
                twelveBtn.backgroundColor = aluminum
            } else if (timeGV == 1) { // if 12HR
                twentyfourBtn.backgroundColor = aluminum
                twelveBtn.backgroundColor = steel
            }
            
            view.backgroundColor = UIColor.white
            dateLbl.textColor = UIColor.black
            timeSettingLbl.textColor = UIColor.black
            themeSettingLbl.textColor = UIColor.black
            whiteBtn.backgroundColor = steel
            blackBtn.backgroundColor = aluminum
            informationBtn.setImage(UIImage(named: "InfoIconBlack"), for: .normal)
            backBtn.setImage(UIImage(named: "ClockIconBlack"), for: .normal)
            break;
        case 1: // black
            if (timeGV == 0) { // if 24HR
                twentyfourBtn.backgroundColor = steel
                twelveBtn.backgroundColor = aluminum
            } else if (timeGV == 1) { // if 12HR
                twentyfourBtn.backgroundColor = aluminum
                twelveBtn.backgroundColor = steel
            }
            
            view.backgroundColor = UIColor.black
            dateLbl.textColor = UIColor.white
            timeSettingLbl.textColor = UIColor.white
            themeSettingLbl.textColor = UIColor.white
            whiteBtn.backgroundColor = aluminum
            blackBtn.backgroundColor = steel
            informationBtn.setImage(UIImage(named: "InfoIconWhite"), for: .normal)
            backBtn.setImage(UIImage(named: "ClockIconWhite"), for: .normal)
            break;
        default:
            if (timeGV == 0) { // if 24HR
                twentyfourBtn.backgroundColor = steel
                twelveBtn.backgroundColor = aluminum
            } else if (timeGV == 1) { // if 12HR
                twentyfourBtn.backgroundColor = aluminum
                twelveBtn.backgroundColor = steel
            }
            
            view.backgroundColor = UIColor.white
            dateLbl.textColor = UIColor.black
            timeSettingLbl.textColor = UIColor.black
            themeSettingLbl.textColor = UIColor.black
            whiteBtn.backgroundColor = steel
            blackBtn.backgroundColor = aluminum
            informationBtn.setImage(UIImage(named: "InfoIconBlack"), for: .normal)
            backBtn.setImage(UIImage(named: "ClockIconBlack"), for: .normal)
            break;
        }
        
        if (dateGV == 0) { // if date off
            offDateBtn.backgroundColor = steel
            onDateBtn.backgroundColor = aluminum
        } else if (dateGV == 1) { // if date on
            offDateBtn.backgroundColor = aluminum
            onDateBtn.backgroundColor = steel
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func selectTwentyFourHour(_ sender: Any) {
        
        twentyfourBtn.backgroundColor = steel
        twelveBtn.backgroundColor = aluminum
        
        UserDefaults.standard.set(0, forKey: "timeGV")
        timeGV = 0
    }
    
    @IBAction func selectTwelveHour(_ sender: Any) {
        
        twentyfourBtn.backgroundColor = aluminum
        twelveBtn.backgroundColor = steel
        
        UserDefaults.standard.set(1, forKey: "timeGV")
        timeGV = 1
    }
    
    @IBAction func selectWhiteTheme(_ sender: Any) {
        
        view.backgroundColor = UIColor.white
        dateLbl.textColor = UIColor.black
        timeSettingLbl.textColor = UIColor.black
        themeSettingLbl.textColor = UIColor.black
        whiteBtn.backgroundColor = steel
        blackBtn.backgroundColor = aluminum
        informationBtn.setImage(UIImage(named: "InfoIconBlack"), for: .normal)
        backBtn.setImage(UIImage(named: "ClockIconBlack"), for: .normal)

        UserDefaults.standard.set(0, forKey: "themeGV")
        themeGV = 0
    }
    
    @IBAction func selectBlackTheme(_ sender: Any) {
        
        view.backgroundColor = UIColor.black
        dateLbl.textColor = UIColor.white
        timeSettingLbl.textColor = UIColor.white
        themeSettingLbl.textColor = UIColor.white
        whiteBtn.backgroundColor = aluminum
        blackBtn.backgroundColor = steel
        informationBtn.setImage(UIImage(named: "InfoIconWhite"), for: .normal)
        backBtn.setImage(UIImage(named: "ClockIconWhite"), for: .normal)

        UserDefaults.standard.set(1, forKey: "themeGV")
        themeGV = 1
    }
    
    @IBAction func selectDateOff(_ sender: Any) {
        
        offDateBtn.backgroundColor = steel
        onDateBtn.backgroundColor = aluminum
        
        UserDefaults.standard.set(0, forKey: "dateGV")
        dateGV = 0
    }
    
    @IBAction func selectDateOn(_ sender: Any) {
        
        offDateBtn.backgroundColor = aluminum
        onDateBtn.backgroundColor = steel
        
        UserDefaults.standard.set(1, forKey: "dateGV")
        dateGV = 1
    }
    
    @IBAction func goToClock(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func seeAppInfo(_ sender: Any) {
        performSegue(withIdentifier: "SettingsToInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SettingsToInfo" {
            if segue.destination is AppInformationViewController {
                // data can be moved here
                print("travelling to info")
            }
        }
    }
}
