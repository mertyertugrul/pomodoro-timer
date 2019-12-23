//
//  PomodoroViewController.swift
//  Promodo Timer
//
//  Created by Mert's Macbook on 18.12.2019.
//  Copyright © 2019 Mert's Macbook. All rights reserved.
//

import Cocoa

class PomodoroViewController:NSViewController, NSApplicationDelegate {

    var minT: Int = 24
    var setMin: Int = 0
    var secT: Int = 60
    var pomodoro: Int = 4
    var elapsePomodoro: Int = 0
    var breakFlag: Bool = false
    var timer = Timer()
    var timerIsOn = false
    var emoji =  "💻"
    var timerActive = false
    
    let delegate = NSApplication.shared.delegate as! AppDelegate
    

    @IBOutlet var timeLabel: NSTextField!
    @IBOutlet var feedbackLabel: NSTextField!
    
    @IBOutlet var currentPomodoro: NSTextField!
    @IBOutlet var leftPomodoro: NSTextField!
    
    @IBOutlet var timeSliderCellOutlet: NSSliderCell!
    @IBOutlet var timeSliderOutlet: NSSlider!
    @IBAction func timeSlider(_ sender: Any) {
        minT = Int((sender as AnyObject).value) - 1
        timeLabel.stringValue = String(minT+1) + ":00"
    }
    
    @IBOutlet var pomodoroInputOutlet: NSTextField!
    
    @IBOutlet var timeButtonCellOutlet: NSButtonCell!
    
    @IBAction func timeButton(_ sender: Any) {
        timerFunction()
    }
    
    func timerFunction() {
        NSLog("hello")
        if timerActive != true{
            timerActive = true
            timButtonOutlet.title = "Pause"
            delegate.buttonTextItem.title = timButtonOutlet.title
            
            if Int(pomodoroInputOutlet.stringValue) != nil {
                feedbackLabel.isHidden = true
                pomodoro = Int(pomodoroInputOutlet.stringValue)!
        } else if pomodoroInputOutlet.stringValue == "" {
                feedbackLabel.isHidden = true
        } else {
            pomodoroInputOutlet.stringValue = ""
            feedbackLabel.stringValue = "Please enter a number."
            return
        }
            delegate.statusItem.button?.title = String(minT) + ":00"
            currentPomodoro.stringValue = String(elapsePomodoro)
            leftPomodoro.stringValue = String(pomodoro)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PomodoroViewController.counter), userInfo: nil, repeats: true)
        } else{
            timerActive = false
            timButtonOutlet.title = "Start"
            delegate.buttonTextItem.title = timButtonOutlet.title
            timer.invalidate()
        }
    }
    
    
    @IBOutlet var timButtonOutlet: NSButton!
    
    
    @objc func counter(){
        if breakFlag == false{
            delegate.statusItem.button?.title = timeLabel.stringValue + emoji + "/" + String(pomodoro)
            timeLabel.textColor = NSColor.red
            emoji = "💻"
            
            timeSliderCellOutlet.isEnabled = false
            secT -= 1
        
            if pomodoro > 0{
                if secT != 0 {
                    timeLabel.stringValue = String(minT) + ":" + String(secT)
                    
                } else {
                    minT -= 1
                    if minT == -1 {
                        NSSound(named: "Purr")?.play()
                        breakFlag = true
                        minT = 4
                        secT = 60
                        return
                    }
                    secT = 59
                    timeLabel.stringValue = String(minT) +  ":" + String(secT) 
                }
            } else{
                timeLabel.stringValue = "00:00"
                NSSound.beep()
                timer.invalidate()
                return
            }
        } else{
            timeLabel.textColor = NSColor.blue
            emoji = "☕️"
            secT -= 1
            
            if secT != 0 {
                timeLabel.stringValue = String(minT) + ":" + String(secT)
            } else {
                minT -= 1
                if minT == -1 {
                    breakFlag = false
                    minT = setMin - 1
                    secT = 60
                    pomodoro -= 1
                    elapsePomodoro += 1
                    currentPomodoro.stringValue = String(elapsePomodoro)
                    leftPomodoro.stringValue = String(pomodoro)
                    return
                }
                secT = 59
                timeLabel.stringValue = String(minT) +  ":" + String(secT)
            }
        }
    }
    
    
    override func viewDidLoad() {
        preferredContentSize = view.frame.size
        delegate.statusItem.button?.title = String(minT+1) + ":00"
        delegate.vcDelegate = self
        super.viewDidLoad()
    }
    
    
}

extension PomodoroViewController: viewControlDelegate{
    func timeFunction() {
        timerFunction()
    }
}
