//
//  movement.swift
//  sheeps
//
//  Created by Ellis Saupe on 5/26/15.
//  Copyright (c) 2015 Xterm2015. All rights reserved.
//
import Foundation
import UIKit


class robot
{
    public init(){}
    let size = Float(arc4random_uniform(250))
    var width: Float = 0.0
    var height: Float = 0.0
    var x: Float = 0.0
    var y: Float = 0.0
    
    var newCoord = [Double]()
    func findVector()
    {
        let speed = Double(arc4random_uniform(11))
        let horizontal = Double(arc4random_uniform(21) - 10)
        let vertical = Double(arc4random_uniform(21) - 10)
        let horiz2 = horizontal * horizontal
        let vert2 = vertical * vertical
        let magnitude = sqrt(vert2 + horiz2)
        newCoord[0] = speed * horizontal/magnitude
        newCoord[1] = speed * vertical/magnitude
    }
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
    
    func cTest(box1: robot, box2: robot)
    {
        if(box1.x < box2.x + box2.width && box1.x + box1.width > box2.x && box1.y < box2.y + box2.height && box1.y + box1.height > box2.y)
        {
            
            
            
        }
    }
    
    
    
}

