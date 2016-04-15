//
//  ViewController.swift
//  calculator
//
//  Created by Ajmal Ahmady on 4/14/16.
//  Copyright © 2016 FrontierGroup. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //*********************************Class Definitions*********************************
    @IBOutlet weak var outputLbl: UILabel!
    var btnSound: AVAudioPlayer!
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    //Enum definition
    enum Operation: String {   //Enum to define a generate data type
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    //*********************************ViewDidLoad()*************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Music playing portion of code
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")  //Get path for a resource
        let soundURL = NSURL(fileURLWithPath: path!) //convert file to URL
        
        //Load audio player with URL contents and queu sounds
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    //******************************Supporting Functions**********************************
    func processOperation(op: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            //Run calculations
            
            //If the user enters two operations without a number between the operations
            if runningNumber != "" {
                
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!))"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
          currentOperation = op
            
        } else {
            //This is the first time an operation has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    //**********************************IBActions*****************************************
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        runningNumber = runningNumber + "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
}