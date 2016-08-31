//
//  App.swift
//  VisualDictionary
//
//  Created by apple on 2016/08/31.
//  Copyright © 2016 Kenta Motomura. All rights reserved.
//

import Foundation
import Cocoa

class App {
	private static var mainWindow: NSWindow? = nil

	static func setMainWindow(mainWindow: NSWindow) {
		self.mainWindow = mainWindow
	}
	
	static func getMainWindow() -> NSWindow {
		return self.mainWindow!
	}
}
