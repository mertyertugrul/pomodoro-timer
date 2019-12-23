//
//  AppDelegate.swift
//  Promodo Timer
//
//  Created by Mert's Macbook on 18.12.2019.
//  Copyright © 2019 Mert's Macbook. All rights reserved.
//

import Cocoa

protocol viewControlDelegate {
    func timeFunction()
    
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate{
    
    var vcDelegate: viewControlDelegate!
    var startTimer = true

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
   
    @IBOutlet var statusTitle: NSMenu!
    
    let buttonTextItem = NSMenuItem(title: "Start", action: #selector(timerButton), keyEquivalent: "")
   
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
//        statusItem.menu = NSMenu()
//        addConfigurationMenuItem()
        
        statusItem.menu = statusTitle
        print(String())
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @IBOutlet var startPause: NSMenuItem!
    @IBAction func startPause(_ sender: NSMenuItem) {
        vcDelegate.timeFunction()
        if startTimer == true{
            startPause.title = "Pause"
            startTimer = false
        } else {
            startPause.title = "Start"
            startTimer = true
        }
    }
    
    @IBAction func showTime(_ sender: NSMenuItem) {
        NSApp.unhide(true)
    }
    
    @IBAction func quitApp(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    

    func addConfigurationMenuItem() {
//        let seperator = NSMenuItem(title: "Time", action: #selector(showTimeWindow), keyEquivalent: "")
//        let quit = NSMenuItem(title: "Quit", action: #selector(quitApp), keyEquivalent: "")
//
//        statusItem.menu?.addItem(seperator)
//        statusItem.menu?.addItem(quit)
//        statusItem.menu?.addItem(buttonTextItem)
    }
    
    @objc func showTimeWindow(_ sender: NSMenuItem) {
        NSApp.unhide(true)
    }
    
//    @objc func quitApp(_ sender: NSMenuItem){
//        NSApplication.shared.terminate(self)
//    }
    
    @objc func timerButton(_ sender: NSMenuItem){
        
    }
}

