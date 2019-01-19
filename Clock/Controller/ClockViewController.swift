//
//  ClockViewController.swift
//  Clock
//
//  Created by Joseph Yuen on 8/2/18.
//  Copyright © 2018 Joseph Yuen. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {

    @IBOutlet weak var middayLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var secondsLbl: UILabel!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet var clockView: UIView!
    
    var hour:Int = 0
    var minute:Int = 0
    var month:Int = 0
    var day:Int = 0
    var second:Int = 0
    var timerGirl = Timer()
    
    //var basicString:String = "23:23"
    //var correctFontSize:CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(clockView.frame.width)")
        print("\(clockView.frame.height)")
        
        /*
        print("Time Label Font:\(timeLbl.font)")
        print("BasicFont Font:\(basicFont)")
        print("Width:\(basicString.width(withConstrainedHeight: 1000, font: basicFont))")
        print("Height:\(basicString.height(withConstrainedWidth: 1000, font: basicFont))")
        
        print("TimeLbl Width:\(UIScreen.main.bounds.width-40)")
        print("TimeLbl Height:\(UIScreen.main.bounds.height-40)")
        
        while (basicString.width(withConstrainedHeight: 1000, font: basicFont) < (UIScreen.main.bounds.width-80)) {
            
            basicFont = UIFont.systemFont(ofSize: correctFontSize, weight:UIFont.Weight.bold)
            
            print("\(correctFontSize)")
            correctFontSize = correctFontSize + 1
            
        }
        
        print("Correct Font Size:\(correctFontSize)")
        
        timeLbl.font = UIFont.systemFont(ofSize: correctFontSize, weight:UIFont.Weight.bold)
         */
        
        // Note: Devices do not know if they are portrait or landscape at the beginning of a program
        
        scaleTimeTextToFrame(label: timeLbl, view:clockView)
        print("isPortrait:\(UIDevice.current.orientation.isPortrait)")
        print("isLandscape:\(UIDevice.current.orientation.isLandscape)")
        //print("\(timeLbl.font)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Retrieve Saved Data
        dateGV = UserDefaults.standard.integer(forKey: "dateGV")
        timeGV = UserDefaults.standard.integer(forKey: "timeGV")
        themeGV = UserDefaults.standard.integer(forKey: "themeGV")
        
        print("Date:\(dateGV)")
        print("Time:\(timeGV)")
        print("Theme:\(themeGV)")
        
        setTheme(theme:themeGV)
        displayDate()
        
        let date = Date()
        let calendar = Calendar.current
        
        hour = calendar.component(.hour, from: date) // default military time
        minute = calendar.component(.minute, from: date)
        month = calendar.component(.month, from: date)
        day = calendar.component(.day, from: date)
        second = calendar.component(.second, from: date)
        
        // Format minutes and seconds to be 2 digits
        let formattedMinute:String = String(format: "%02d", minute)
        let formattedSecond:String = String(format: "%02d", second)
        
        // Set date
        dateLbl.text = "\(month)/\(day)"
        
        // Set seconds
        secondsLbl.text = "\(formattedSecond)"
        
        // Set midday, hour, and minutes
        if (timeGV == 0) { // if 24HR
            middayLbl.isHidden = true
            timeLbl.text = "\(hour):\(formattedMinute)"
        } else if (timeGV == 1) { // if 12HR
            middayLbl.isHidden = false
            if (hour == 0) {
                middayLbl.text = "AM"
                timeLbl.text = "12:\(formattedMinute)"
            } else if (hour>11) {
                middayLbl.text = "PM"
                timeLbl.text = "\(hour-12):\(formattedMinute)"
            } else {
                middayLbl.text = "AM"
                timeLbl.text = "\(hour):\(formattedMinute)"
            }
        }
        
        startTimer()
        
        timeLbl.layer.borderColor = UIColor.black.cgColor
        timeLbl.layer.borderWidth = 3.0;
        
        //var stringTest:String = "23:23"
        //var fontTest = UIFont(descri, size: 180)
        //print("stringTest width: \(stringTest.width(withConstrainedHeight: 100, font: <#T##UIFont#>))")
        //print("stringTest height: \(stringTest.height(withConstrainedWidth: 100, font: <#T##UIFont#>))")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        // make special cases for iPad Retina and iPad 2
        // need to check for side panel
        // see if UIScreen.main.bounds is hardware or digital screen
        
        // iPad 9.7" Dimensions
        // Width = 768
        // Height = 1024
        // Correct Font Size
        // Portrait: 250
        // Landscape: 343
        
        // also find override for when people multitask on iPads
        
        print("\(clockView.frame.width)")
        print("\(clockView.frame.height)")
        
        if UIDevice.current.orientation.isLandscape {
            print("Landscape Orientation:")
            print("TimeLbl Width:\(UIScreen.main.bounds.width-80)")
            print("TimeLbl Height:\(UIScreen.main.bounds.height-80)")
            scaleTimeTextToFrame(label: timeLbl, view:clockView)
        } else  {
            print("Portrait Orientation:")
            print("TimeLbl Width:\(UIScreen.main.bounds.width-80)")
            print("TimeLbl Height:\(UIScreen.main.bounds.height-80)")
            scaleTimeTextToFrame(label: timeLbl, view:clockView)
        }
        
        //print("\(timeLbl.font)")

    }
    
    func setTheme(theme:Int) {
        
        switch theme {
        case 0:
            view.backgroundColor = UIColor.white
            middayLbl.textColor = UIColor.black
            dateLbl.textColor = UIColor.black
            timeLbl.textColor = UIColor.black
            secondsLbl.textColor = UIColor.black
            settingsBtn.setImage(UIImage(named: "GearIconBlack"), for: .normal)
            break;
        case 1: // black
            view.backgroundColor = UIColor.black
            dateLbl.textColor = UIColor.white
            middayLbl.textColor = UIColor.white
            timeLbl.textColor = UIColor.white
            secondsLbl.textColor = UIColor.white
            settingsBtn.setImage(UIImage(named: "GearIconWhite"), for: .normal)
            break;
        default:
            view.backgroundColor = UIColor.white
            middayLbl.textColor = UIColor.black
            dateLbl.textColor = UIColor.black
            timeLbl.textColor = UIColor.black
            secondsLbl.textColor = UIColor.black
            settingsBtn.setImage(UIImage(named: "GearIconBlack"), for: .normal)
            break;
        }
        
    }
    
    func displayDate() {
        if (dateGV == 0) { // if date is off
            dateLbl.isHidden = true
        } else if (dateGV == 1) {
            dateLbl.isHidden = false
        }
    }
    
    func startTimer() {
        timerGirl = Timer.scheduledTimer(timeInterval:0.25, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    @objc
    func  update() {
        
        let date = Date()
        let calendar = Calendar.current
        
        hour = calendar.component(.hour, from: date) // default military time
        minute = calendar.component(.minute, from: date)
        month = calendar.component(.month, from: date)
        day = calendar.component(.day, from: date)
        second = calendar.component(.second, from: date)
        
        // Format minutes and seconds to be 2 digits
        let formattedMinute:String = String(format: "%02d", minute)
        let formattedSecond:String = String(format: "%02d", second)
        
        // Set date
        dateLbl.text = "\(month)/\(day)"
        
        // Set seconds
        secondsLbl.text = "\(formattedSecond)"
        
        // Set midday, hour, and minutes
        if (timeGV == 0) { // if 24HR
            timeLbl.text = "\(hour):\(formattedMinute)"
        } else if (timeGV == 1) { // if 12HR
            if (hour == 0) {
                middayLbl.text = "AM"
                timeLbl.text = "12:\(formattedMinute)"
            } else if (hour>11) {
                middayLbl.text = "PM"
                timeLbl.text = "\(hour-12):\(formattedMinute)"
            } else {
                middayLbl.text = "AM"
                timeLbl.text = "\(hour):\(formattedMinute)"
            }
        }

        //timeLbl.fitTextToBounds()
        
        //timeLbl.text = "23:46"
    }
    
    func stopTimer() {
        print("Timer Stopped")
        timerGirl.invalidate()
    }
    
    @IBAction func goToSettings(_ sender: Any) {
        stopTimer()
        performSegue(withIdentifier: "ClockToSettings", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ClockToSettings" {
            if segue.destination is SettingsViewController {
                // data can be moved here
                print("travelling to settings")
            }
        }
    }
    
}

