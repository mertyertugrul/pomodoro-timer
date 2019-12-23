//
//  windowController.swift
//  Promodo Timer
//
//  Created by Mert's Macbook on 20.12.2019.
//  Copyright © 2019 Mert's Macbook. All rights reserved.
//

import Cocoa

class windowController: NSWindowController, NSWindowDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        NSApp.hide(nil)
        return false
    }

}
