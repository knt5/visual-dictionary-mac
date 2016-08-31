//
//  Config.swift
//  VisualDictionary
//
//  Created by apple on 2016/08/23.
//  Copyright © 2016 Kenta Motomura. All rights reserved.
//

import Foundation

class Config {
	private static let userDefaults = NSUserDefaults.standardUserDefaults()
	
	//============================================================
	// Default settings
	private static let defaults: Dictionary = [
		// Main window position and size
		//"window.main.x": 40.0,
		//"window.main.y": 40.0,
		"window.main.width": 800.0,
		"window.main.height": 600.0,
		
		// Speech
		"speech": true,
		
		// Dictionary search engine
		"searchEngines": [
			SearchEngine(name:"ALC", url:"http://eow.alc.co.jp/search?q=", id:"#resultsArea"),
			SearchEngine(name:"Weblio", url:"http://ejje.weblio.jp/content/")
		],
		
		// Image search engine
		"imageSearchEngines": [
			SearchEngine(name:"Google", url:"https://www.google.co.jp/search?tbm=isch&safe=high&q=")
		]
	]
	
	//============================================================
	// Access to NSUserDefaults
	
	// Save
	private static func save(key: String, value: AnyObject) {
		userDefaults.setObject(value, forKey: key)
		userDefaults.synchronize()
	}
	
	// Load
	private static func load(key: String) -> AnyObject {
		if (defaults[key] != nil) {
			userDefaults.registerDefaults([key: defaults[key]!])
		}
		return userDefaults.objectForKey(key)!
	}
	
	//============================================================
	// Config interface
	
	// Speech
	class var speech: Bool {
		get {
			return load("speech") as! Bool
		}
		set(v) {
			save("speech", value:v)
		}
	}
	
	// Main window position
	/*
	class var mainWindowPosition: NSPoint {
		get {
			let x: CGFloat = load("window.main.x") as! CGFloat
			let y: CGFloat = load("window.main.y") as! CGFloat
			return NSMakePoint(x, y)
		}
		set(point) {
			save("window.main.x", value:point.x)
			save("window.main.y", value:point.y)
		}
	}
	*/
	
	// Main window frame
	class var mainWindowFrame: NSRect {
		get {
			//let x: CGFloat = load("window.main.x") as! CGFloat
			//let y: CGFloat = load("window.main.y") as! CGFloat
			let w: CGFloat = load("window.main.width") as! CGFloat
			let h: CGFloat = load("window.main.height") as! CGFloat
			//return NSMakeRect(x, y, w, h)
			return NSMakeRect(0.0, 0.0, w, h)
		}
		set(rect) {
			//save("window.main.x", value:rect.origin.x)
			//save("window.main.y", value:rect.origin.y)
			save("window.main.width", value:rect.size.width)
			save("window.main.height", value:rect.size.height)
		}
	}
	
	//----------------------------------------
	// Default only
	
	// searchEngines
	// - This version has the default setting only
	static func getSearchEngines() -> [SearchEngine] {
		return defaults["searchEngines"] as! [SearchEngine]
	}
	
	// imageSearchEngines
	// - This version has the default setting only
	static func getImageSearchEngines() -> [SearchEngine] {
		return defaults["imageSearchEngines"] as! [SearchEngine]
	}
}
