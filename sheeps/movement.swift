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
    let size = CGFloat(arc4random_uniform(140) + 10)
    var width: Float = 0.0
    var height: Float = 0.0
    var x: Float = 0.0
    var y: Float = 0.0
    
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
    }
    var imageView = UIImageView()
    
    func Vector()
    {
        let speed = Int(arc4random_uniform(10) + 1)
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
    }
    
    func cTest(box1: robot, box2: robot)
    {
        if(box1.x < box2.x + box2.width && box1.x + box1.width > box2.x && box1.y < box2.y + box2.height && box1.y + box1.height > box2.y)
        {
            
            
            
        }
    }
    
    
}

