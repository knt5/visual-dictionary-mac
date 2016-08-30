//
//  AppDelegate.swift
//  VisualDictionary
//
//  Created by apple on 2016/08/19.
//  Copyright © 2016 Kenta Motomura. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	func applicationDidFinishLaunching(aNotification: NSNotification) {
	}

	func applicationWillTerminate(aNotification: NSNotification) {
	}
	
	func applicationShouldHandleReopen(sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
		if (flag == false) {
			sender.windows[0].makeKeyAndOrderFront(self)
		} else {
			sender.windows[0].orderFront(self)
		}
		return true
	}
	
	/*
	func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
		return true
	}
	*/
}
