//
//  customerTimer.swift
//  NSTimer
//
//  Created by Mac on 10/24/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation


class TimerClass {
    
    
    var timer : NSTimer!
    var seconds = 0
    var secondsString = "00"
    var minutes = 0
    var minutesString = "00"
    
    
    var timerString : String?
    
    
    private  var _parent = HomeVC()
    
    var parent : HomeVC {
        
        set{
            _parent = newValue
            
        }get {
            
            return _parent
            
        }
        
    }
    
    
    
    
    init() {
        
        
        
          timer = NSTimer(timeInterval: 1.0, target: self, selector: #selector(countUp), userInfo: nil, repeats: true)
          NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    
    }
    
    
    
    @objc func countUp() {
        
        seconds += 1
        
        if(seconds == 60){
            
            minutes += 1
            seconds = 0
        }
        if (seconds < 10){
            
            secondsString = "0\(seconds)"
            
        }else{
            
            secondsString = "\(seconds)"
        }
        
        if (minutes < 10){
            
            minutesString = "0\(minutes)"
            
        }else{
            
            minutesString = "\(minutes)"
            
        }
        
         timerString = "\(minutesString) : \(secondsString)"
        
         self.parent.updateTimerLabel(timerString!)
        
    }

 
    
    

}
