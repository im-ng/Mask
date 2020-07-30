//
//  ViewController.swift
//  Mask
//
//  Created by ng on 29/07/20.
//  Copyright © 2020 ng. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var toggleSwitch: NSSwitch!
    var toggleTask:Process!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toggleSwitch.target = self
        self.toggleSwitch.action = #selector(maskDesktopIcons(_:))
        //Preload existing status
        let value = self.executeCommand("defaults read com.apple.finder CreateDesktop")
        if (value == "true\n") {
            self.toggleSwitch.state = NSControl.StateValue.off
        } else {
            self.toggleSwitch.state = NSControl.StateValue.on
        }
    }

    //Toggle desktop icons
    @objc func maskDesktopIcons(_ sender: NSSwitch) {
        switch sender.state {
            case NSControl.StateValue.on:
                _ = executeCommand("defaults write com.apple.finder CreateDesktop false; killall Finder")
            case NSControl.StateValue.off:
                _ = executeCommand("defaults write com.apple.finder CreateDesktop true; killall Finder")
            default:
                break
        }
    }
    
    //Execute command on Process(NSTask)
    func executeCommand(_ argument: String) -> String {
      let pipe = Pipe()
      self.toggleTask = Process()
      self.toggleTask.launchPath = "/bin/sh"
      self.toggleTask.arguments = ["-c", String(format:"%@", argument)]
      self.toggleTask.standardOutput = pipe
      let file = pipe.fileHandleForReading
      self.toggleTask.launch()
      self.toggleTask.waitUntilExit()
      if let result = NSString(data: file.readDataToEndOfFile(), encoding: String.Encoding.utf8.rawValue) {
        return result as String
      } else {
        return "Task failed!"
      }
    }
}

