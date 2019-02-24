//
//  AppInformationViewController.swift
//  Clock
//
//  Created by Joseph Yuen on 8/2/18.
//  Copyright © 2018 Joseph Yuen. All rights reserved.
//

import UIKit

class AppInformationViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Retrieve Saved Data
        dateGV = UserDefaults.standard.integer(forKey: "dateGV")
        timeGV = UserDefaults.standard.integer(forKey: "timeGV")
        themeGV = UserDefaults.standard.integer(forKey: "themeGV")
        
        setTheme(theme:themeGV)
    }

    func setTheme(theme:Int) {
        
        switch theme {
        case 0: // white
            view.backgroundColor = UIColor.white
            titleLbl.textColor = UIColor.black
            infoLbl.textColor = UIColor.black
            backBtn.setImage(UIImage(named: "GearIconBlack"), for: .normal)
            break;
        case 1: // black
            view.backgroundColor = UIColor.black
            titleLbl.textColor = UIColor.white
            infoLbl.textColor = UIColor.white
            backBtn.setImage(UIImage(named: "GearIconWhite"), for: .normal)
            break;
        default:
            view.backgroundColor = UIColor.white
            titleLbl.textColor = UIColor.black
            infoLbl.textColor = UIColor.black
            backBtn.setImage(UIImage(named: "GearIconBlack"), for: .normal)
            break;
        }
    }
    
    @IBAction func goBackToSettings(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
