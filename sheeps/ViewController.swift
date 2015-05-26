//
//  ViewController.swift
//  sheeps
//
//  Created by Nathan Scheidler on 5/26/15.
//  Copyright (c) 2015 Xterm2015. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        var screen: CGRect! = UIScreen.mainScreen().bounds
        var width = screen.width
        var height = screen.height

        func buildMenu()
        {
            self.view.backgroundColor = UIColor.blackColor()
            var startbtn = UIButton.buttonWithType(UIButtonType.System) as UIButton
            startbtn.frame = CGRectMake(width/2 - 25, height/2 - 30, 50, 25)
            startbtn.backgroundColor = UIColor.greenColor()
            startbtn.setTitle("Start", forState:UIControlState.Normal)
            startbtn.addTarget(self, action:"startGame:", forControlEvents:UIControlEvents.TouchUpInside)
        }
        
        func startGame(sender: UIButton!)
        {}
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

