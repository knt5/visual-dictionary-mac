//
//  ViewController.swift
//  VisualDictionary
//
//  Created by apple on 2016/08/19.
//  Copyright © 2016 Kenta Motomura. All rights reserved.
//

import Cocoa
import WebKit

class ViewController: NSViewController {
	// UI
	@IBOutlet var mainView: NSView!
	@IBOutlet weak var searchField: NSSearchField!
	@IBOutlet weak var searchEnginePopUpButton: NSPopUpButton!
	@IBOutlet weak var imageSearchEnginePopUpButton: NSPopUpButton!
	@IBOutlet weak var dictionaryWebView: WebView!
	@IBOutlet weak var imageWebView: WebView!
	
	// App config
	private let config: Config = Config()
	
	// TextView for speech
	private let textView: NSTextView = NSTextView(frame: NSMakeRect(-1, -1, 0, 0))
	
	//============================================================
	override var representedObject: AnyObject? {
		didSet {
		}
	}
	
	//============================================================
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//============================================================
		// Setup UI
		
		// Add search engines to PopUpButton
		config.getSearchEngines().forEach { (engine : SearchEngine) -> () in
			searchEnginePopUpButton.addItemWithTitle(engine.name)
		}
		
		// Add image search engines to PopUpButton
		config.getImageSearchEngines().forEach { (engine : SearchEngine) -> () in
			imageSearchEnginePopUpButton.addItemWithTitle(engine.name)
		}
		
		//============================================================
		// Set preferences of WebView
		
		// Set preferences ID to separate preferences of WebViews
		dictionaryWebView.preferencesIdentifier = "dictionary"
		imageWebView.preferencesIdentifier = "image"
		
		// Set preferences to block Ads
		dictionaryWebView.preferences.javaScriptEnabled = false
		dictionaryWebView.preferences.loadsImagesAutomatically = false
	}
	
	//============================================================
	// Get selected search engine for dictionary
	private func getSearchEngine() -> SearchEngine {
		return config.getSearchEngines()[searchEnginePopUpButton.indexOfSelectedItem]
	}
	
	//============================================================
	// Get selected image search engine
	private func getImageSearchEngine() -> SearchEngine {
		return config.getImageSearchEngines()[imageSearchEnginePopUpButton.indexOfSelectedItem]
	}
	
	//============================================================
	@IBAction func onSearchAction(sender: AnyObject) {
		if (searchField.stringValue.characters.count > 0) {
			// Start speaking keyword (Recommended speech voice is "Samantha")
			if (config.speaking) {
				textView.string = searchField.stringValue
				textView.startSpeaking(nil)
			}
			
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
