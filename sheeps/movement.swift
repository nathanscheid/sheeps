//
//  movement.swift
//  sheeps
//
//  Created by Ellis Saupe on 5/26/15.
//  Copyright (c) 2015 Xterm2015. All rights reserved.
//
import Foundation
import UIKit

func random() -> Int
{
    return Int(arc4random_uniform(21))
}

class robot
{
    public init(){}
    var size = CGFloat(arc4random_uniform(165) + 10)
    
    var startX: CGFloat = 0.0
    var startY: CGFloat = 0.0
    
    var timer: NSTimer!
    
    var newY: CGFloat! = 0
    var newX: CGFloat! = 0
   
    var robImage: UIImage?
    func getImg()
    {
        let robot1 = UIImage(named: "robot1") as UIImage?
        let robot2 = UIImage(named: "robot2") as UIImage?
        let robot3 = UIImage(named: "robot3") as UIImage?
        let type = Int(arc4random_uniform(3))
        
        switch type
        {
        case 0:
            robImage = robot1!
        case 1:
            robImage = robot2!
        default:
            robImage = robot3!
        }

        //robImage = UIImage(named: "red") as UIImage?
    }
    var imageView = UIImageView()

    func Vector()
    {
        let speed = Int(arc4random_uniform(5) + 1)
        var yChange = random() - 10
        var xChange = Int(arc4random_uniform(21)) - 10
        
        if yChange == 0 && xChange == 0
        {
            yChange = 1
            xChange = -1
        }
        
        let magnitude = Int(sqrt(Double(yChange*yChange + xChange*xChange)))
        newX = CGFloat(speed * xChange/magnitude)
        newY = CGFloat(speed * yChange/magnitude)
        if newX == 0 && newY == 0
        {
            newX = 1
            newY = -1
        }
    }
}

