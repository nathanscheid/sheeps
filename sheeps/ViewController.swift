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
    var gameURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("game", ofType: "wav")!)
    
    var menuPlayer = AVAudioPlayer()
    var menuURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("menu", ofType: "wav")!)
    
    var sfxPlayer = AVAudioPlayer()
    var eatURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("eat", ofType: "wav")!)
    var dieURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("die", ofType: "wav")!)
    

    var screen: CGRect! = UIScreen.mainScreen().bounds
    var width: CGFloat!
    var height: CGFloat!
    
    var startbtn: UIButton!
    var start = UIImage(named:"Start") as UIImage?
    var creditbtn: UIButton!
    var menuLabel = UILabel()
    var menuBG = UIImage(named:"title") as UIImage?
    
    var menubtn: UIButton!
    var restart: UIButton!
    var restartImg = UIImage(named: "restart") as UIImage?
    var backArrow = UIImage(named: "arrow") as UIImage?
    var bg = UIImage(named: "gameBG") as UIImage?
    var inGame = false
    var sheep = robot()
    
    var robTime: NSTimer!
    
    var robMovement: NSTimer!
    
    var locationX: CGFloat! = 0
    var locationY: CGFloat! = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        width = screen.width
        height = screen.height
        buildMenu()
        
    }
    
    func buildMenu()
    {
        menuPlayer = AVAudioPlayer(contentsOfURL: menuURL, error: nil)
        menuPlayer.numberOfLoops = -1
        menuPlayer.play()
        
        self.view.backgroundColor = UIColor(patternImage:menuBG!)
        
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
        menuPlayer.stop()
        inGamePlayer = AVAudioPlayer(contentsOfURL: gameURL, error: nil)
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
        
        restart = UIButton.buttonWithType(UIButtonType.System) as UIButton
        restart.frame = CGRectMake(width - 70, 0, 30, 30)
        restart.setBackgroundImage(restartImg, forState: UIControlState.Normal)
        restart.addTarget(self, action:"restart:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(restart)
        
        sheep.robImage = UIImage(named:"sheep") as UIImage?
        sheep.imageView.image = sheep.robImage
        sheep.size = 30
        sheep.imageView.frame = CGRectMake(0,0,sheep.size,sheep.size)
        self.view.addSubview(sheep.imageView)
        
        sheep.timer = NSTimer.scheduledTimerWithTimeInterval(0.0167, target: self, selector: Selector("sheepMove"), userInfo: nil, repeats: true)
        robTime = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("robotSpawn"), userInfo: nil, repeats: true)
    }
    
    func robotSpawn()
    {
        var robotExample = robot()
        
        robotExample.startX = width
        robotExample.startY = height
        robotExample.Vector()
        robotExample.getImg()
        robotExample.imageView.image = robotExample.robImage
        robotExample.imageView.frame = CGRectMake(robotExample.startX, robotExample.startY, robotExample.size, robotExample.size)
        robotExample.timer =  NSTimer.scheduledTimerWithTimeInterval(0.0167, target: self, selector: Selector("robotMove:"), userInfo: robotExample, repeats: true)
        self.view.addSubview(robotExample.imageView)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        var touch = touches.anyObject()! as UITouch
        locationX = touch.locationInView(self.view).x
        locationY = touch.locationInView(self.view).y
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent)
    {
        var touch = touches.anyObject()! as UITouch
        locationX = touch.locationInView(self.view).x
        locationY = touch.locationInView(self.view).y
    }
    
    func sheepMove()
    {
        var xdiff = locationX - sheep.imageView.center.x
        var ydiff = locationY - sheep.imageView.center.y
        
        var magnitude = sqrt(xdiff*xdiff + ydiff*ydiff)
        
        if magnitude <= 6
        {
            sheep.imageView.frame=CGRectMake(locationX - sheep.size/2, locationY - sheep.size/2, sheep.size, sheep.size)
        }
        else
        {
            var newX: CGFloat! = 6 * xdiff/magnitude + sheep.imageView.frame.origin.x
            var newY: CGFloat! = 6 * ydiff/magnitude + sheep.imageView.frame.origin.y
            sheep.imageView.frame=CGRectMake(newX, newY, sheep.size, sheep.size)
        }
    }
    
    func robotMove(timer: NSTimer)
    {
        var bot = timer.userInfo as robot
        let robX = bot.imageView.frame.origin.x + bot.newX
        let robY = bot.imageView.frame.origin.y + bot.newY
        bot.imageView.frame = CGRectMake(robX, robY, bot.size, bot.size)
        
        if inGame == false || posTest(bot).outOfScreen
        {
            timer.invalidate()
            bot.imageView.removeFromSuperview()
        }
        if posTest(bot).collision == true
        {
            sheepCollision(bot)
        }
    }
    
    func posTest(bot: robot) -> (outOfScreen:Bool, collision: Bool)
    {
        let x = bot.imageView.frame.origin.x
        let y = bot.imageView.frame.origin.y
        var outOfScreen = false
        var collided = false
        if x > width || y > height || x < 0 - bot.size || y < 0 - bot.size
        {
            outOfScreen = true
        }
        var xCol = false
        var yCol = false
        
        //test for same x
        if sheep.imageView.frame.origin.x <= bot.imageView.frame.origin.x && sheep.imageView.frame.origin.x + sheep.size >= bot.imageView.frame.origin.x
        {
            xCol = true
        }
            
        else if sheep.imageView.frame.origin.x <= bot.imageView.frame.origin.x + bot.size && sheep.imageView.frame.origin.x + sheep.size >= bot.imageView.frame.origin.x + bot.size
        {
            xCol = true
        }
        
        //test for same y
        if sheep.imageView.frame.origin.y <= bot.imageView.frame.origin.y && sheep.imageView.frame.origin.y + sheep.size >= bot.imageView.frame.origin.y
        {
            yCol = true
        }
            
        else if sheep.imageView.frame.origin.y <= bot.imageView.frame.origin.y + bot.size && sheep.imageView.frame.origin.y + sheep.size >= bot.imageView.frame.origin.y + bot.size
        {
            yCol = true
        }
        
        if xCol == true && yCol == true
        {
            collided = true
        }
        return (outOfScreen, collided)
    }
    
    func sheepCollision(bot: robot)
    {
        if sheep.size > bot.size
        {
            sheep.size = sheep.size + 5
            bot.imageView.frame = CGRectMake(width + 5, height + 5, 0, 0)
            bot.imageView.removeFromSuperview()
            sfxPlayer = AVAudioPlayer(contentsOfURL: eatURL, error: nil)
            sfxPlayer.play()
        }
        else
        {
            sfxPlayer = AVAudioPlayer(contentsOfURL: dieURL, error: nil)
            sfxPlayer.play()
            inGamePlayer.stop()
            robTime.invalidate()
            sheep.timer.invalidate()
            inGame = false
            clearView()
            self.view.addSubview(menubtn)
            
            self.view.addSubview(restart)
            
            sheep.robImage = UIImage(named:"deadSheep") as UIImage?
            sheep.imageView.image = sheep.robImage
            sheep.imageView.frame = CGRectMake(width/2 - sheep.size/2, height/2 - sheep.size/2, sheep.size, sheep.size)
            self.view.addSubview(sheep.imageView)

        }
    }
    
    func restart(sender: UIButton!)
    {
        locationX = 0
        locationY = 0
        inGame = false
        inGamePlayer.stop()
        robTime.invalidate()
        sheep.timer.invalidate()
        clearView()
        startGame(sender)
    }
    
    func backMenu(sender: UIButton!)
    {
        locationX = 0
        locationY = 0
        inGame = false
        inGamePlayer.stop()
        robTime.invalidate()
        sheep.timer.invalidate()
        clearView()
        buildMenu()
    }
    
    func showCredits(sender: UIButton!)
    {}
    
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

