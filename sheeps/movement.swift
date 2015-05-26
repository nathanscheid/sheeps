//
//  movement.swift
//  sheeps
//
//  Created by Ellis Saupe on 5/26/15.
//  Copyright (c) 2015 Xterm2015. All rights reserved.
//
import Foundation
import UIKit

class rBox
{
    var width: Float = 0.0
    var height: Float = 0.0
    var x: Float = 0.0
    var y: Float = 0.0
    
}


func cTest(box1: rBox, box2: rBox)
{
    if(box1.x < box2.x + box2.width && box1.x + box1.width > box2.x && box1.y < box2.y + box2.height && box1.y + box1.height > box2.y)
    {
        
        
        
    }
}