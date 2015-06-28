//
//  ViewController.swift
//  Calculator
//
//  Created by Raju on 3/06/2015.
//  Copyright (c) 2015 Damodar Gundu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

 
    @IBOutlet weak var display: UILabel!
    
    var userIsInMiddleOfTyping: Bool = false
    var operandStack = Array<Double>()
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInMiddleOfTyping {
            enter()
        }
        switch operation {
        case "x": performOperation { $0 * $1 }
        case "+": performOperation { $0 + $1 }
        case "÷": performOperation { $1 / $0 }
        case "-": performOperation { $1 - $0 }
//        case "√": performOperation { sqrt($0) }
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) ->Double) {
        if operandStack.count >= 2 {
            displayValue = operation (operandStack.removeLast(),operandStack.removeLast())
             enter()
        }
    }
    
//    func performOperation(operation: Double -> Double) {
//        if operandStack.count >= 1 {
//            displayValue = operation (operandStack.removeLast())
//            enter()
//        }
//    }

    
    @IBAction func enter() {
       userIsInMiddleOfTyping = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInMiddleOfTyping = false
        }
    
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        
        let digit = sender.currentTitle!
        if userIsInMiddleOfTyping {
            display.text = display.text! + digit
            
        }else{
            display.text = digit
            userIsInMiddleOfTyping = true
        }
    }
}

