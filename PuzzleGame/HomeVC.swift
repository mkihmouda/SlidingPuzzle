//
//  GameVC.swift
//  IPuzzle
//
//  Created by Mac on 10/22/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import UIKit
import AVFoundation

class HomeVC: UIViewController {
    
    // blocks images
    
    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    @IBOutlet var fourthImageView: UIImageView!
    @IBOutlet var fifthImageView: UIImageView!
    @IBOutlet var sixthImageView: UIImageView!
    @IBOutlet var seventhImageView: UIImageView!
    @IBOutlet var eigthImageView: UIImageView!
    @IBOutlet var ninethImageView: UIImageView!
    @IBOutlet var tenthImageView: UIImageView!
    @IBOutlet var elefenthImageView: UIImageView!
    @IBOutlet var twelveImageView: UIImageView!
    @IBOutlet var thirteenImageView: UIImageView!
    @IBOutlet var fourtheenImageView: UIImageView!
    @IBOutlet var fifteenImageView: UIImageView!
    @IBOutlet var emptyImageView: UIImageView!
    
    
    
    var imageBlocksArray = [UIImageView]()
    var puzzlegame : PuzzleGame!
    var randomArray : RandomUniquieArray!
    
    
    var nav : UINavigationController?
    var btnSound : AVAudioPlayer?
    var winnerBtnSound : AVAudioPlayer?
    
    
    var soundEnabel = true
    var soundImage : UIImage?
    
    @IBOutlet var soundButton: UIButton!
    @IBOutlet var timerLabel: UILabel!
    
    
    @IBOutlet var score_game: UILabel!
    @IBOutlet var level_game: UILabel!
    
    var timer : TimerClass!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // male unquieArray
        
        randomArray = RandomUniquieArray.init()
                
        self.navigationController?.navigationBar.hidden = true
        
        // define sound class
        
        let soundClass = SoundPlayer.init(trackName: "game")
        btnSound = soundClass.btnSound
        
        
        
        // define sound class
        
        let soundWinnerClass = SoundPlayer.init(trackName: "winner")
        winnerBtnSound = soundWinnerClass.btnSound
        
        
        
        // define timer class
        
        timer = TimerClass.init()
        timer.parent = self
        
        
        // define puzzle game class
        
        imageBlocksArray.append(firstImageView)
        imageBlocksArray.append(secondImageView)
        imageBlocksArray.append(thirdImageView)
        imageBlocksArray.append(fourthImageView)
        imageBlocksArray.append(fifthImageView)
        imageBlocksArray.append(sixthImageView)
        imageBlocksArray.append(seventhImageView)
        imageBlocksArray.append(eigthImageView)
        imageBlocksArray.append(ninethImageView)
        imageBlocksArray.append(tenthImageView)
        imageBlocksArray.append(elefenthImageView)
        imageBlocksArray.append(twelveImageView)
        imageBlocksArray.append(thirteenImageView)
        imageBlocksArray.append(fourtheenImageView)
        imageBlocksArray.append(fifteenImageView)
        imageBlocksArray.append(emptyImageView)
        
        
        puzzlegame = PuzzleGame.init(parent: self)
        
    
        
    }
    
    // MARK: Override viewWillAppear func
    
    
    override func viewWillAppear(animated: Bool) {
        
        
        soundEnabel = !soundEnabel
        self.soundButtonAction(self.soundButton)
        
    }
    
 
    
    
    
    func reloadGame (){
        
 
        
        // reload time
        
        timer = TimerClass.init()
        timer.parent = self
        
        // reload blocks
        
        puzzlegame = PuzzleGame.init(parent: self)
        
        
        
        // play sound
        
        if (soundEnabel){
            
            btnSound?.currentTime = 0
            btnSound!.play()
            
        }
        
        
        
    }
  
    
    
    
    
    // MARK: sound functions
    
    
    @IBAction func soundButtonAction(sender: AnyObject) {
        
        let soundButton = sender as? UIButton
        
        if (soundEnabel){
            
            soundImage = UIImage.init(named: "mute")
            soundEnabel = false
            
        }else{
            
            soundImage = UIImage.init(named: "sound")
            soundEnabel = true
            
        }
        
        soundButton!.setImage(soundImage, forState: .Normal)
        playSound()
        
    }
    
    
    
    func playSound(){
        
        if (btnSound!.playing){
            
            btnSound!.stop()
            
        }else if (soundEnabel){
            
            btnSound!.play()
            
        }
        
    }
    
    
    func playSuccessSound(){
        
        // stop game sound
        
        if (soundEnabel){
            
            btnSound!.stop()
            
        }
        
        // play winner sound
        winnerBtnSound?.currentTime = 0
        winnerBtnSound!.play()
        
        
    }
    
    
   
    
    // MARK: timer game update label
    
    
    func updateTimerLabel(timeString : String) {
        
        timerLabel.text = timeString
        
    }
    
    // MARK: handle game swipper
    
    func handleSwipe(sender: UISwipeGestureRecognizer) {
        
        if (puzzlegame.checkAvaliableMovement(sender.direction.rawValue, sender: (sender.view as? UIImageView)!)){
            
            let senderImageView = sender.view as? UIImageView
            let destinationImageView = puzzlegame.destinationImageBlock(sender.direction.rawValue, senderTag: (senderImageView?.tag)!)
            
            puzzlegame.swapImageBlocks(senderImageView!, destinationImageView: destinationImageView)
            
            
            if puzzlegame.checkWinCase(){
                
                endRound()
                
            }
            
        }
        
    }
    
    
    // MARK: Quite functions
    
    
    @IBAction func showQuiteAlarmView(sender: AnyObject) {
        
        
        exit(0)
        
        
    }
    
   
    
    // MARK: hint view
    
    
    
    @IBAction func showHintAction(sender: AnyObject) {
        
        
        let alert = UIAlertController(title: "Hint", message: " some hints ", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion:nil)
        
        
    }
    
    
    // MARK: end round functions
    
    
    func endRound(){
        
        
        // stop previous and play winner Sound
        
        playSuccessSound()
        
        
        // stop timer
        
        timer.timer.invalidate()
        
        
        let alert = UIAlertController(title: "Success", message: " You Win ", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion:nil)
        
    }
    
    
    
}
