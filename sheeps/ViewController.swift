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

    var screen: CGRect! = UIScreen.mainScreen().bounds
    var width: CGFloat!
    var height: CGFloat!
    var startbtn: UIButton!
    var creditbtn: UIButton!
    var menubtn: UIButton!
    var backArrow = UIImage(named: "arrow") as UIImage?
    
    var menuLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        width = screen.width
        height = screen.height
        self.view.backgroundColor = UIColor.blackColor()
        buildMenu()
        
    }
    
    func buildMenu()
    {
        startbtn = UIButton.buttonWithType(UIButtonType.System) as UIButton
        startbtn.frame = CGRectMake(width/2 - 25, height/2 - 30, 50, 25)
        startbtn.backgroundColor = UIColor.redColor()
        startbtn.setTitle("Start", forState:UIControlState.Normal)
        startbtn.addTarget(self, action:"startGame:", forControlEvents:UIControlEvents.TouchUpInside)
        startbtn.layer.cornerRadius = 5
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
        clearView()
        menubtn = UIButton.buttonWithType(UIButtonType.System) as UIButton
        menubtn.frame = CGRectMake(-20 + width, 0, 20, 20)
        menubtn.setBackgroundImage(backArrow, forState: UIControlState.Normal)
        menubtn.addTarget(self, action:"backMenu:", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(menubtn)
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

