//
//  PuzzleGame.swift
//  blocksProject
//
//  Created by Mac on 10/24/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation
import UIKit

class PuzzleGame {

    private  var _parent = HomeVC()
    var score_value : Int?
    
     var gesturesArray = [UISwipeGestureRecognizer]()
    
    
    
    var parent : HomeVC {
        
        set{
            _parent = newValue
            
        }get {
            
            return _parent
            
        }
        
    }
    
    
    
    
    init(parent : HomeVC) {
        
        
        self.parent = parent
    
        setImageRandomlyAndDefineAccessibilityLabel()
        defineImageGestures()

    }
    
    
    
    func setImageRandomlyAndDefineAccessibilityLabel(){
    
    
        for i in 1 ..< self.parent.imageBlocksArray.count {
            
            
            let levelValue = 0

            
            let imageView : UIImageView = self.parent.view.viewWithTag(i) as! UIImageView
            
             

            let image : UIImage = UIImage.init(named: "\(levelValue)-\(self.parent.randomArray.uniqueArray[i-1])")!
            imageView.image = image
            imageView.image?.accessibilityLabel = "\(self.parent.randomArray.uniqueArray[i-1])"
 
        
        }
        
        
        let imageView : UIImageView = self.parent.view.viewWithTag(16) as! UIImageView
        imageView.image?.accessibilityLabel = "16"
    }
    
    
    
    
    func defineImageGestures(){
   
    for i in 0 ... 15 {

        let directions: [UISwipeGestureRecognizerDirection] = [.Right, .Left, .Up, .Down]
        for direction in directions {

                let imageGesture = UISwipeGestureRecognizer(target: self.parent, action: #selector(parent.handleSwipe(_:)))
                imageGesture.direction = direction
                
 
                self.parent.imageBlocksArray[i].userInteractionEnabled = true
                self.parent.imageBlocksArray[i].addGestureRecognizer(imageGesture)

        
        }
        
    } }
    
    
    
    

// MARK: game methods definition
    
    
    func checkAvaliableMovement(direction : UInt, sender : UIImageView ) -> Bool{
        
        
        if (direction == 1 && sender.tag != 4 && sender.tag != 8 && sender.tag != 12 && sender.tag != 16) {
            
            
            let destinationImageView : UIImageView = self.parent.view.viewWithTag(sender.tag + 1) as! UIImageView
            
            if (destinationImageView.image?.accessibilityLabel != "16"){
                
                return false
                
            }else{
                
                return true
            }
            
        }else if (direction == 2  && sender.tag != 1 && sender.tag != 5 && sender.tag != 9 && sender.tag != 13){
            
            
            let destinationImageView : UIImageView = self.parent.view.viewWithTag(sender.tag - 1) as! UIImageView
            
            if (destinationImageView.image?.accessibilityLabel != "16"){
                
                return false
                
            }else{
                
                return true
            }
            
        }else if (direction == 4  && sender.tag != 1 && sender.tag != 2 && sender.tag != 3 && sender.tag != 4){
            
            
            let destinationImageView : UIImageView = self.parent.view.viewWithTag(sender.tag - 4) as! UIImageView
            
            if (destinationImageView.image?.accessibilityLabel != "16"){
                
                return false
                
            }else{
                
                return true
            }
            
        }else if (direction == 8  && sender.tag != 13 && sender.tag != 14 && sender.tag != 15 && sender.tag != 16){
            
            
            let destinationImageView : UIImageView = self.parent.view.viewWithTag(sender.tag + 4) as! UIImageView
            
            if (destinationImageView.image?.accessibilityLabel != "16"){
                
                return false
                
            }else{
                
                return true
            }
        }
  
        else{
            
            return false
            
        }
        
        
    }

    
   
    
    func checkWinCase() -> Bool{
        
        for i in 1 ... 16 {

            let targetImageView : UIImageView = self.parent.view.viewWithTag(i) as! UIImageView
            
            if(targetImageView.image?.accessibilityLabel != "\(i)"){
                
                return false
                
            }
        }

        calculateScore() // get score according to current time
        
        return true
  
    }
    
    
 
    func destinationImageBlock(direction : UInt, senderTag: Int) -> UIImageView{
        
        var destinationImageView : UIImageView!
        
        if (direction == 1){
            
            destinationImageView = self.parent.view.viewWithTag(senderTag + 1) as! UIImageView
            
            
        }else if (direction == 2){
            
            destinationImageView = self.parent.view.viewWithTag(senderTag - 1) as! UIImageView
            
            
        }else if (direction == 4){
            
            destinationImageView = self.parent.view.viewWithTag(senderTag - 4) as! UIImageView
            
            
        }else if (direction == 8){
            
            destinationImageView = self.parent.view.viewWithTag(senderTag + 4) as! UIImageView
            
        }
        
        return destinationImageView
        
    }
    
    
    
    func swapImageBlocks(senderImageView : UIImageView, destinationImageView: UIImageView){
        
        
        let swapImage = destinationImageView.image
        destinationImageView.image = senderImageView.image
        senderImageView.image = swapImage
        

    }
    
    func calculateScore(){
        
        if (self.parent.timer.minutes < 5){
            
            score_value = 100
        
        }else if (self.parent.timer.minutes >= 5 && self.parent.timer.minutes < 10){
            
            score_value = 50
            
        }else if (self.parent.timer.minutes >= 10 && self.parent.timer.minutes < 20){
            
            score_value = 30
            
        }else{
        
            score_value = 10
        }
        

    }
    

}