//
//  Config.swift
//  VisualDictionary
//
//  Created by apple on 2016/08/23.
//  Copyright © 2016 Kenta Motomura. All rights reserved.
//

import Foundation

class Config {
	private let searchEngines: [SearchEngine]
	private let imageSearchEngines: [SearchEngine]
	let speaking: Bool
	
	init() {
		searchEngines = [
			SearchEngine(name:"ALC", url:"http://eow.alc.co.jp/search?q=", id:"#resultsArea")
		]
		
		imageSearchEngines = [
			SearchEngine(name:"Google", url:"https://www.google.co.jp/search?tbm=isch&safe=high&q=")
		]
		
		speaking = true
	}
	
	func getSearchEngines() -> [SearchEngine] {
		return searchEngines
	}
	
	func getImageSearchEngines() -> [SearchEngine] {
		return imageSearchEngines
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
}
