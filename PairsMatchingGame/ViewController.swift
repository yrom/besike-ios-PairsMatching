//
//  ViewController.swift
//  PairsMatchingGame
//
//  Created by yrom on 14-11-7.
//  Copyright (c) 2014年 yrom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var stepper: UIStepper!
    weak var revealButton: UIButton!
    weak var shuffleButton: UIButton!
    
    /// read-only
    var pairsCount: Double {
        return self.stepper.value
    }
    
    var cardsCount: Double {
        get{
            return self.pairsCount * 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControls()
   }

    
    func setupControls() {
        // An UIStepper
        let stepperFrame = CGRect(x: 113, y: 20, width: 94, height: 29)
        // An UIButton
        let revealButtonFrame = CGRect(x: 16, y: 20, width: 47, height: 30)
        // An UIButton
        let shuffleButtonFrame = CGRect(x: 256, y: 20, width: 48, height: 30)
        
        // Add the UI controls in code.
        let revealButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        revealButton.frame = revealButtonFrame
        revealButton.setTitle("Reveal", forState: UIControlState.Normal)
        self.revealButton = revealButton
        let shuffleButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
        shuffleButton.frame = shuffleButtonFrame
        shuffleButton.setTitle("Shuffle", forState: UIControlState.Normal)
        self.shuffleButton = shuffleButton
        
        // Configure the stepper to allow values beween 1 and 10 (default: 4).
        // The step increment should be 1.
        let stepper = UIStepper(frame: stepperFrame)
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.value = 4
        stepper.stepValue = 1
        self.stepper = stepper

        self.view.addSubview(revealButton)
        self.view.addSubview(shuffleButton)
        self.view.addSubview(stepper)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

