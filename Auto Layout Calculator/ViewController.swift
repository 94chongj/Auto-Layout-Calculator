//
//  ViewController.swift
//  Auto Layout Calculator
//
//  Created by Jonathan Chong on 4/13/18.
//  Copyright © 2018 Jonathan Chong. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var answer : Float = 0
    var num1 : String = "" /*also hold final value in case user wants to continue using value
 or be emptied because of clear function */
    var num2 : String = "" //needs to be emptied to account for continuation or clear function
    var operatorEval : String = ""//needs to be emptied on clear button or equal button is pressed so user can further calculate
    var cleanSlate : Bool = true//will be true on fresh star, clear button is pressed, or equals button is pressed
    var calculationsText : String = ""//updated until equals button pressed to present final answer then modified accordingly based on continuation
    var equalsActivated : Bool = false//checks to see if equal button was pressed once... checks to see if this is continuation
    var decimalPointExists : Bool = false//used to check for decimals and present formatted numbers on the screen
    
    
    @IBOutlet weak var calculations: UILabel!
    
    @IBAction func Button(_ sender: UIButton) {
        
        func clearAll() {
            if sender.tag == 11 {//clear button check
                cleanSlate = true
                calculationsText = ""
                calculations.text = ""
                num1 = ""
                num2 = ""
                operatorEval = ""
                equalsActivated = false
                decimalPointExists = false
            }
        }
        
        func runNum() {
            if operatorEval == "" {
                num1 = storeNum1AndNum2(num : num1)
            }
            else if operatorEval != ""{ //checks to see if an operator button was pressed
                //decimalPointExists = false // sets decimal point bool to false because num2 has no decimal yet until sender.tag == 10 (did not incorporate because allowed for 89.5.5.5 ... sets decimalPointExists to false when it is not needed)
                num2 = storeNum1AndNum2(num: num2)
            }
        }//end of second number function
        
        
        func storeNum1AndNum2(num : String) -> String{
            var num = num // var num = num1 or num2
            if sender.tag == 0 {
                if num != "" { //checks to see if num1 contains any # 1-9 because 0198 doesn't make sense as a whole number... it would just be 198
                    num += "0"
                    calculationsText += "0"
                    cleanSlate = false
                }
            }
            else if sender.tag == 10 {//decimal point
                if decimalPointExists == false{ //can only be one decimal point in a float
                    if num1 != "" && num2 == "" && operatorEval != ""{ //adds decimal to start of num2
/*
                         case 1: no decimal point exists means a decimal point can be added to either num1 or num 2 (decimalpointexists = false)
                         case 2: a decimal point cannot be added to num2 when num2 is empty
 */
                        num += "."
                        calculationsText += "."
                        decimalPointExists = true
                        cleanSlate = false
                    }
                    else if num1 != "" && num2 != "" && operatorEval != ""{ // adds decimal point to num2
                        num += "."
                        calculationsText += "."
                        decimalPointExists = true
                        cleanSlate = false
                    }
                    else if num1 != "" && operatorEval == "" && num2 == ""{ //adds decimal point to num1
                        num += "."
                        calculationsText += "."
                        decimalPointExists = true
                        cleanSlate = false
                    }
                    else {
                        calculations.text = "Error, Please Clear"
                    }
                    /*else if cleanSlate == true {
                        num += "."
                        calculationsText += "."
                        decimalPointExists = true
                        cleanSlate = false
                    }*/
                }
            }
            else if sender.tag == 1 {
                num += "1"
                calculationsText += "1"
                cleanSlate = false
            }
            else if sender.tag == 2 {
                num += "2"
                calculationsText += "2"
                cleanSlate = false
            }
            else if sender.tag == 3 {
                num += "3"
                calculationsText += "3"
                cleanSlate = false
            }
            else if sender.tag == 4 {
                num += "4"
                calculationsText += "4"
                cleanSlate = false
            }
            else if sender.tag == 5 {
                num += "5"
                calculationsText += "5"
                cleanSlate = false
            }
            else if sender.tag == 6 {
                num += "6"
                calculationsText += "6"
                cleanSlate = false
            }
            else if sender.tag == 7 {
                num += "7"
                calculationsText += "7"
                cleanSlate = false
            }
            else if sender.tag == 8 {
                num += "8"
                calculationsText += "8"
                cleanSlate = false
            }
            else if sender.tag == 9 {
                num += "9"
                calculationsText += "9"
                cleanSlate = false
            }
            else {
                calculations.text = "Error, Please Clear"
            }
            calculations.text = calculationsText
            return num
        }
        
        func operatorApply(operatorStr : String) -> String{
            var operatorStr = operatorStr
            if sender.tag == 14 {//divide
                operatorStr += "/"
                calculationsText += "÷"
            }
            else if sender.tag == 15 {//multiply
                operatorStr += "*"
                calculationsText += "*"
            }
            else if sender.tag == 16 {//minus
                operatorStr += "-"
                calculationsText += "-"
            }
            else if sender.tag == 17 {//add
                operatorStr += "+"
                calculationsText += "+"
            }
            else {
                calculations.text = "Error, Please Clear"
            }
            cleanSlate = true
            //decimalPointExists = false /might be the reason why you can make num1 = 89.1.1.1.1
            calculations.text = calculationsText
            return operatorStr
        }
        
        func equals() {
            if sender.tag == 18 && num2 != ""{//equals
                var num1Float : Float? = Float(num1)
                var num2Float : Float? = Float(num2)
                if operatorEval == "/" {
                    answer = num1Float!/num2Float!
                }
                else if operatorEval == "*" {
                    answer = num1Float!*num2Float!
                }
                else if operatorEval == "-" {
                    answer = num1Float!-num2Float!
                }
                else if operatorEval == "+" {
                    answer = num1Float! + num2Float!
                }
                var answerString : String? = String(answer)
                var answerFloatRemove = String(format: "%.0f", answer)
                var ansString = answerString!.split(separator:".")//splits the answer by removing the decimalpoint and giving two numbers in an array
                if ansString[1] != "0" {//
                    calculations.text = "\(answer)"
                    num1 = "\(answer)" //store the final answer in num1 to prepare for continuation
                    calculationsText = "\(answer)"
                }
                else if ansString[1] == "0" {// if the 1st element(by zero indexing) is = 0 then there is no reason to have a decimal point so it is better to just return an integer
                    calculations.text = answerFloatRemove
                    num1 = answerFloatRemove //store the final answer in num1 to prepare for continuation
                    calculationsText = answerFloatRemove
                }
                else {
                    calculations.text = "Error, Please Clear"
                }
                equalsActivated = true
                cleanSlate = true
                operatorEval = ""
                num2 = ""
            }
        }
        
        // ----------------------
        
        if cleanSlate == true { //then calculations label = "" and it's a fresh start
            if equalsActivated == false {
                if operatorEval == "" {
                    operatorEval = operatorApply(operatorStr: operatorEval)
                    if operatorEval != ""  && num2 == ""{
                        decimalPointExists = false
                    }
                    runNum()
                }
                else if operatorEval != "" {
                    if num2 == "" {
                        decimalPointExists = false
                    }
                    runNum()
                }
            }
            else if equalsActivated == true {
                if operatorEval == "" {
                    operatorEval = operatorApply(operatorStr: operatorEval)
                    if operatorEval != "" {
                        decimalPointExists = false
                    }
                }
                else {
                    runNum()
                }
            }
        }
        else if cleanSlate == false { //not a fresh start
            if equalsActivated == false {
                if operatorEval == "" {
                    operatorEval = operatorApply(operatorStr: operatorEval)
                    if operatorEval != "" {
                        decimalPointExists = false
                    }
                }
                runNum()
            }
            else if equalsActivated == true {
                if operatorEval == "" {
                    operatorEval = operatorApply(operatorStr: operatorEval)
                    if operatorEval != "" {
                        decimalPointExists = false
                    }
                }
                runNum()
            }
        }
        if num2 != "" || operatorEval != "" {//cannot run equals() when screen shows "1+"
            equals()
            //decimalPointExists = false // keep this in mind... might not be needed
        }
        clearAll()
        print ("operator = "+operatorEval)
        print ("num1 = "+num1)
        print ("num2 = "+num2)//issue right now is that operator is not being assigned on continuation
        print ("equalsActivated = "+"\(equalsActivated)")
        print ("cleanSlate = "+"\(cleanSlate)")
        print ("decimalPointExists = "+"\(decimalPointExists)")
        print("       ")
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

