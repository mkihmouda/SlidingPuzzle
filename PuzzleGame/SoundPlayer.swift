//
//  SoundPlayer.swift
//  IPuzzle
//
//  Created by Mac on 10/23/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
import AVFoundation

class SoundPlayer {
    
    var btnSound : AVAudioPlayer!

  
    
    init(trackName : String) {
        
        
        let path =  NSBundle.mainBundle().pathForResource("\(trackName)", ofType: "wav")
        let soundURL =  NSURL(fileURLWithPath:path!)

        do{
            
            try  btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound?.prepareToPlay()
            
        } catch let err as NSError{
            
            print(err.debugDescription)
            
        }

    }
}