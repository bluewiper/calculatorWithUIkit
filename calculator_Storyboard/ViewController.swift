//
//  ViewController.swift
//  calculator_Storyboard
//
//  Created by 단예진 on 6/24/24.
//


/*
 소수점을 고려하지 않은, 정수형 계산만 하며
 모든 연산 버튼을 클릭할때마다 계산이 이루어지도록 하지는 않으며
 등호 버튼 (=) 을 클릭했을 때만 연산이 이루어지도록 합니다.
 수식 문자열이 들어왔을 때 이를 계산해주는 Swift 의 기본 제공 기능을 활용합니다 
 0이 있으면 0을 뺴고 탭한 버튼의 상태를 적용할 수 있도록 해라.*/

/* my expecting properties: firstNum, secondNum, operation, setOperation(연속적 연산을 위한 연산 기호 호출), haveReuslt(중간 연산 결과), numAfterResult(중간 연산 결과값), resultNum(최종 연산 결과), allClear(초기화) */

import UIKit

class ViewController: UIViewController {
    
    var firstNum: String = ""
    var operation: String = ""
    //firstNum, secondNum에 대한 연산 후 결과값 다음 연산이 있을 수도 있고, 없을 수도 있다.
    var haveResult: Bool = false
    var secondNum: String = ""
    //firstNum, secondNum에 대한 연산 후 결과값
    var resultNum: String = ""
    var numAfterResult: String = ""
    
    @IBOutlet weak var numOnScreen: UILabel!
    
    // 숫자버튼 액션
    @IBAction func numberTapped(_ sender: UIButton) {
        if operation == "" {
            firstNum += String(sender.tag) //연속적으로 숫자(태그 Int값)가 입력할 수 있도록
            numOnScreen.text = firstNum
        } else if operation != "" && !haveResult {
            secondNum += String(sender.tag)
            numOnScreen.text = secondNum
        } else if operation != "" && haveResult {
            numAfterResult += String(sender.tag)
            numOnScreen.text = numAfterResult
        }
    }
    
    
    // 연산기호 버튼 액션
    @IBAction func allClearBtnTapped(_ sender: UIButton) {
        firstNum = ""
        operation = ""
        haveResult = false
        secondNum = ""
        resultNum = ""
        numAfterResult = "" // 관련 변수를 모두 초기화해서 잔여데이터로 인한 오류 방지
        numOnScreen.text = "0"
    }
    
    @IBAction func equals(_ sender: UIButton) {
        resultNum = String(doOperation())
        numOnScreen.text = resultNum
        numAfterResult = "" // 빈 문자열로 초기화해서 새로운 계산이 시작될 때 이전 계산값을 비워준다.
        firstNum = resultNum // 결과를 첫 번째 숫자로 설정하여 연속 연산이 가능하도록
        secondNum = ""
        operation = ""
        haveResult = true
    }
    
    @IBAction func add(_ sender: UIButton) {
        setOperation("+")
    }
    
    @IBAction func subtract(_ sender: UIButton) {
        setOperation("-")
    }
    
    @IBAction func multiply(_ sender: UIButton) {
        setOperation("*")
    }
    
    @IBAction func divide(_ sender: UIButton) {
        setOperation("/")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //기본 텍스트는 "0"이 되도록 합니다.
        numOnScreen.text = "0"
        
    }
    func doOperation() -> Int {
        guard let firstNumber = Int(firstNum) else { return 0 }
        
        if operation == "+" {
            if !haveResult {
                haveResult = true
                return firstNumber + (Int(secondNum) ?? 0)
            } else {
                return (Int(resultNum) ?? 0) + (Int(numAfterResult) ?? 0)
            }
        } else if operation == "-" {
            if !haveResult {
                haveResult = true
                return firstNumber - (Int(secondNum) ?? 0)
            } else {
                return (Int(resultNum) ?? 0) - (Int(numAfterResult) ?? 0)
            }
        } else if operation == "*" {
            if !haveResult {
                haveResult = true
                return firstNumber * (Int(secondNum) ?? 0)
            } else {
                return (Int(resultNum) ?? 0) * (Int(numAfterResult) ?? 0)
            }
        } else if operation == "/" {
            if !haveResult {
                haveResult = true
                return firstNumber / (Int(secondNum) ?? 0)
            } else {
                return (Int(resultNum) ?? 0) / (Int(numAfterResult) ?? 0)
            }
        }
        return 0
    }
    func setOperation(_ op: String) {
            if !firstNum.isEmpty && secondNum.isEmpty {
                operation = op
                haveResult = false
            } else if !secondNum.isEmpty {
                resultNum = String(doOperation())
                numOnScreen.text = resultNum
                firstNum = resultNum  // 결과를 첫 번째 숫자로 설정하여 연속 연산이 가능
                secondNum = ""
                operation = op
                haveResult = true
            }
        }
}





