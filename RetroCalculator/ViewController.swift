//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Michael Fenech on 3/01/2016.
//  Copyright © 2016 michael fenech. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Addition = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl:UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    
    var leftValString = ""
    
    var rightValString = ""
    
    var currentOperation: Operation = Operation.Empty
    
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
    
    }
    
    @IBAction func clearPressed(btn: UIButton!) {
        runningNumber = "0"
        leftValString = ""
        rightValString = ""
        outputLbl.text = runningNumber
        currentOperation = Operation.Empty
        playSound()
    }


    @IBAction func numberPressed(btn: UIButton!) {
        btnSound.play()
        runningNumber = ""
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        playSound()
    }

    @IBAction func OnDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func OnMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func OnSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }

    @IBAction func OnAddPressed(sender: AnyObject) {
        processOperation(Operation.Addition)
    }

    @IBAction func OnEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }

    func processOperation(op: Operation) {
        playSound()
        
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                
                rightValString = runningNumber
                runningNumber = ""

                if  currentOperation == Operation.Multiply {
                    
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                    
                } else if currentOperation == Operation.Divide {
                    
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                    
                } else if currentOperation == Operation.Subtract {
                    
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                    
                } else if currentOperation == Operation.Addition {
                    
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                
                leftValString = result
                outputLbl.text = result
            }
            
            currentOperation = op
            
        } else {
            leftValString = runningNumber
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

}


