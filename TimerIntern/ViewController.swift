//
//  ViewController.swift
//  TimerIntern
//
//  Created by Nazerke Sembay on 09.04.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    
    var time = 0
    var startTime = 0
    var timer = Timer()
    var isTimerRunning = false
    var counter = 1
    var currentTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            if isTimerRunning {
                clean()
            }
            
            counter = 1
            
        } else if sender.selectedSegmentIndex == 1{
            if isTimerRunning {
               clean()
            }
            
            counter = 2
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        clean()
    }
    
    @IBAction func play(_ sender: Any) {
        if isTimerRunning{
            return
        }
        
        if counter == 1 {
            time = 1000
            
            if currentTime != 0{
                time = currentTime
            }
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countTimeTimer), userInfo: nil, repeats: true)
        } else if counter == 2{
            time = 0
            
            if currentTime != 0{
                time = currentTime
            }
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countTimeSeconds), userInfo: nil, repeats: true)
        }
        
        isTimerRunning = true
    }
    
    @IBAction func pause(_ sender: Any) {
        currentTime = time
        timer.invalidate()
        isTimerRunning = false
    }
    
    func timeToString(intTime: Int) -> String{
        let seconds = intTime % 60
        let minutes = (intTime / 60) % 60
        let hours = intTime / 3600
        
        return String(format: "%0.2d:%0.2d:%0.2d", hours,minutes,seconds)
        
    }
    
    @objc func countTimeTimer(){
        time -= 1
        timerLabel.text = timeToString(intTime: time)
        
        if time == 0{
            timer.invalidate()
            isTimerRunning = false
            currentTime = 0
        }
   }
    
    @objc func countTimeSeconds(){
        time += 1
        timerLabel.text = timeToString(intTime: time)
   }
    
    func clean(){
        timer.invalidate()
        time = startTime
        isTimerRunning = false
        timerLabel.text = timeToString(intTime: time)
    }
    
}

