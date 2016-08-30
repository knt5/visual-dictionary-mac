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
	private static let defaults = [
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
		
		/*
		// Speech
		static let speech: Bool = true
		
		// Dictionary search engine
		static let searchEngines: [SearchEngine] = [
			SearchEngine(name:"ALC", url:"http://eow.alc.co.jp/search?q=", id:"#resultsArea"),
			SearchEngine(name:"Weblio", url:"http://ejje.weblio.jp/content/")
		]
		
		// Image search engine
		static let imageSearchEngines: [SearchEngine] = [
			SearchEngine(name:"Google", url:"https://www.google.co.jp/search?tbm=isch&safe=high&q=")
		]
		*/
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
	// Setting interfaces
	
	// Speech
	class var speech: Bool {
		get {
			return load("speech") as! Bool
		}
		set(v) {
			save("speech", value:v);
		}
	}
	
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
	
	
	
	/*
	private var userDefaults: NSUserDefaults
	private var searchEngines: [SearchEngine]
	private var imageSearchEngines: [SearchEngine]
	private var speech: Bool
	
	init() {
		userDefaults = NSUserDefaults.standardUserDefaults()
		
		searchEngines = [
			SearchEngine(name:"ALC", url:"http://eow.alc.co.jp/search?q=", id:"#resultsArea"),
			SearchEngine(name:"Weblio", url:"http://ejje.weblio.jp/content/")
		]
		
		imageSearchEngines = [
			SearchEngine(name:"Google", url:"https://www.google.co.jp/search?tbm=isch&safe=high&q=")
		]
		
		speech = true
	}

	func getSearchEngines() -> [SearchEngine] {
		return searchEngines
	}
	
	func getImageSearchEngines() -> [SearchEngine] {
		return imageSearchEngines
	}
	
	func getSpeechState() -> Bool {
		return true;
	}
	
	func saveSpeechState() -> Bool {
		
		return true;
	}
	
	// Load config
	private func load() -> Bool {
		return true
	}
	
	// Save config
	private func save() -> Bool {
		//let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
		//defaults.setObject("aaa", forKey: "searchTarget")
		return true
	}
	*/
}
