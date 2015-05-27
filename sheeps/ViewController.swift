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
    
    
    var inGamePlayer = AVAudioPlayer()
    var menuURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("menu", ofType: "wav")!)
    

    var screen: CGRect! = UIScreen.mainScreen().bounds
    var width: CGFloat!
    var height: CGFloat!
    
    var startbtn: UIButton!
    var start = UIImage(named:"Start") as UIImage?
    var creditbtn: UIButton!
    var menuLabel = UILabel()
    
    var menubtn: UIButton!
    var backArrow = UIImage(named: "arrow") as UIImage?
    var bg = UIImage(named: "gameBG") as UIImage?
    var inGame = false
    var sheepView = UIImageView()
    var sheep = UIImage(named:"sheep") as UIImage?
    
    var robTime: NSTimer!
    
    var timer: NSTimer!
    var locationX: CGFloat!
    var locationY: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        width = screen.width
        height = screen.height
        buildMenu()
        
    }
    
    func buildMenu()
    {
        self.view.backgroundColor = UIColor.blackColor()
        startbtn = UIButton.buttonWithType(UIButtonType.System) as UIButton
        startbtn.frame = CGRectMake(width/2 - 25, height/2 - 30, 50, 40)
        startbtn.setBackgroundImage(start, forState: UIControlState.Normal)
        startbtn.addTarget(self, action:"startGame:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(startbtn)
        
        creditbtn = UIButton.buttonWithType(UIButtonType.System) as UIButton
        creditbtn.frame = CGRectMake(width/2 - 25, height/2 + 5, 50, 25)
        creditbtn.backgroundColor = UIColor.greenColor()
        creditbtn.setTitle("Credits", forState:UIControlState.Normal)
        creditbtn.addTarget(self, action:"showCredits:", forControlEvents:UIControlEvents.TouchUpInside)
        creditbtn.layer.cornerRadius = 5
        self.view.addSubview(creditbtn)
        
        menuLabel.frame = CGRectMake(width/2 - 100, 100, 200, 50)
        menuLabel.textColor = UIColor.blueColor()
        menuLabel.textAlignment = NSTextAlignment.Center
        menuLabel.font = UIFont(name: menuLabel.font.fontName, size: 18)
        menuLabel.text = "XTERM 2K15"
        self.view.addSubview(menuLabel)
    }
    
    func startGame(sender: UIButton!)
    {
        inGamePlayer = AVAudioPlayer(contentsOfURL: menuURL, error: nil)
        inGamePlayer.numberOfLoops = -1
        inGamePlayer.play()
        
        clearView()
        inGame = true
        self.view.backgroundColor = UIColor(patternImage:bg!)
        
        menubtn = UIButton.buttonWithType(UIButtonType.System) as UIButton
        menubtn.frame = CGRectMake(-30 + width, 0, 30, 30)
        menubtn.setBackgroundImage(backArrow, forState: UIControlState.Normal)
        menubtn.addTarget(self, action:"backMenu:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(menubtn)
        
        sheepView.image = sheep!
        sheepView.frame = CGRectMake(0,0,30,30)
        self.view.addSubview(sheepView)
        
        robTime = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("robotSpawn"), userInfo: nil, repeats: true)
        func robotSpawn()
        {
            var robotExample = robot()
            robotExample.width = robotExample.size
            robotExample.height = robotExample.size
            robotExample.findVector()
            robotExample.x = Float(Int(width)/2 - Int(robotExample.size/2))
            robotExample.y = Float(Int(height)/2 - Int(robotExample.size/2))
            robotExample.getImg()
            robotExample.imageView.image = robotExample.robImage
            robotExample.imageView.frame = CGRectMake(CGFloat(robotExample.x), CGFloat(robotExample.y), CGFloat(robotExample.size), CGFloat(robotExample.size))
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        var touch = touches.anyObject()! as UITouch
        locationX = touch.locationInView(self.view).x
        locationY = touch.locationInView(self.view).y
        if inGame == true
        {
            timer = NSTimer.scheduledTimerWithTimeInterval(0.0167, target: self, selector: Selector("sheepMove"), userInfo: nil, repeats: true)
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
    {
        var touch = touches.anyObject()! as UITouch
        locationX = touch.locationInView(self.view).x
        locationY = touch.locationInView(self.view).y
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        timer.invalidate()
    }
    
    func sheepMove()
    {
        var xdiff = locationX - sheepView.center.x
        var ydiff = locationY - sheepView.center.y
        
        var magnitude = sqrt(xdiff*xdiff + ydiff*ydiff)
        
        if magnitude <= 6
        {
            sheepView.frame=CGRectMake(locationX - 15, locationY - 15, 30, 30)
        }
        else
        {
            var newX: CGFloat! = 6 * xdiff/magnitude + sheepView.frame.origin.x
            var newY: CGFloat! = 6 * ydiff/magnitude + sheepView.frame.origin.y
            sheepView.frame=CGRectMake(newX, newY, 30, 30)
        }
   
    }
    
    func showCredits(sender: UIButton!)
    {}
    
    func backMenu(sender: UIButton!)
    {
        clearView()
        buildMenu()
    }
    
    func clearView()
    {
        for view in self.view.subviews
        {
            view.removeFromSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

