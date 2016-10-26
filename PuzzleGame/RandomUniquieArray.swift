//
//  RandomUniquieArray.swift
//  IPuzzle
//
//  Created by Mac on 10/25/16.
//  Copyright © 2016 Mac. All rights reserved.
//

import Foundation

class RandomUniquieArray {
    
    var uniqueArray = [Int]()

    
    init() {
    
    
            for i in 0 ..< 15 {
        
                var  randomNumber =   Int(arc4random_uniform(15) + 1)
        
                    while (checkExist(randomNumber)){
            
                        randomNumber =   Int(arc4random_uniform(15) + 1)
            
                    }
        
                uniqueArray.append(randomNumber)
        
            }
    
        
    }




  func checkExist(randomNumber : Int) -> Bool {
    
      for i in 0 ..< self.uniqueArray.count{
            
           if (randomNumber == uniqueArray[i]) {
                
                return true
            }
            
        }
        
        return false
        
   }
    
    
    
}
