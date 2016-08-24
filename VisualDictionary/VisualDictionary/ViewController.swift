//
//  ViewController.swift
//  VisualDictionary
//
//  Created by apple on 2016/08/19.
//  Copyright © 2016年 Kenta Motomura. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
	@IBOutlet var mainView: NSView!
	@IBOutlet weak var searchField: NSSearchField!
	@IBOutlet weak var searchEnginePopUpButton: NSPopUpButton!
	@IBOutlet weak var imageSearchEnginePopUpButton: NSPopUpButton!
	@IBOutlet weak var dictionaryWebView: WebView!
	@IBOutlet weak var imageWebView: WebView!
	
	private let config: Config = Config()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		config.getSearchEngines().forEach { (engine : SearchEngine) -> () in
			searchEnginePopUpButton.addItemWithTitle(engine.name)
		}
		
		config.getImageSearchEngines().forEach { (engine : SearchEngine) -> () in
			imageSearchEnginePopUpButton.addItemWithTitle(engine.name)
		}
	}
	
	override var representedObject: AnyObject? {
		didSet {
			// Update the view, if already loaded.
		}
	}
	
	private func getSearchEngine() -> SearchEngine {
		return config.getSearchEngines()[searchEnginePopUpButton.indexOfSelectedItem]
	}
	
	private func getImageSearchEngine() -> SearchEngine {
		return config.getImageSearchEngines()[imageSearchEnginePopUpButton.indexOfSelectedItem]
	}
	
	@IBAction func onSearchAction(sender: AnyObject) {
		if (searchField.stringValue.characters.count > 0) {
			// Get keyword
			let key: String = searchField.stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet())!
			
			// Create URL
			let engine: SearchEngine = getSearchEngine()
			let imageEngine: SearchEngine = getImageSearchEngine()
			let searchEngineUrl: String = engine.url + key + engine.id
			let imageSearchEngineUrl: String = imageEngine.url + key + imageEngine.id
			
			// Load web pages
			dictionaryWebView.mainFrameURL = searchEngineUrl
			imageWebView.mainFrameURL = imageSearchEngineUrl
		}
	}
	
}
