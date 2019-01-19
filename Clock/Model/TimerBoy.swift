//
//  TimerBoy.swift
//  Clock
//
//  Created by Joseph Yuen on 8/4/18.
//  Copyright © 2018 Joseph Yuen. All rights reserved.
//

import Foundation

// maybe use in the future? because encaptulation...

class TimerBoy {
    
    var timer: Timer?
    //var timerStart: Date?
    
    var count = 0
    
    init() {
        print("you have created a TimerDemo")
    }
    
    func startTimer() {
        // get current system time
        //timerStart = Date()
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval:1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
    }
    
    @objc
    func  update() {
        /*
         // get the current system time
         let now = Date()
         
         // get the seconds since start
         let seconds = now.timeIntervalSince(timerStart)
         */
        count = count + 1
        print("\(count)")
    }
    
    func stopTimer() {
        print("Timer Stopped")
        timer?.invalidate()
    }
}
