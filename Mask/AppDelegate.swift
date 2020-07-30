//
//  AppDelegate.swift
//  Mask
//
//  Created by ng on 29/07/20.
//  Copyright © 2020 ng. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let menu = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.menu.button?.title = "M"
        self.menu.button?.target = self
        self.menu.button?.action = #selector(self.previewView)
        self.menu.button?.image = NSImage(named: "Mask")
    }

    @objc func previewView() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: "VC1") as? ViewController else {
            fatalError("VC1 is not found!")
        }
        guard let button = self.menu.button else {
            fatalError("Menu bar button is not found!")
        }
        let popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
        popoverView.show(relativeTo: button.bounds, of: button, preferredEdge: .maxY)
    }
}

