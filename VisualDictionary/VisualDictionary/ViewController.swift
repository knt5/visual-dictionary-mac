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
	@IBOutlet var mainView: NSView!
	@IBOutlet weak var searchField: NSSearchField!
	@IBOutlet weak var searchEnginePopUpButton: NSPopUpButton!
	@IBOutlet weak var imageSearchEnginePopUpButton: NSPopUpButton!
	@IBOutlet weak var dictionaryWebView: WebView!
	@IBOutlet weak var imageWebView: WebView!
	
	override var representedObject: AnyObject? { didSet {} }
	//override var acceptsFirstResponder: Bool { return true }
	
	private let config: Config = Config()
	private let textView: NSTextView = NSTextView(frame: NSMakeRect(-1, -1, 0, 0))
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		config.getSearchEngines().forEach { (engine : SearchEngine) -> () in
			searchEnginePopUpButton.addItemWithTitle(engine.name)
		}
		
		config.getImageSearchEngines().forEach { (engine : SearchEngine) -> () in
			imageSearchEnginePopUpButton.addItemWithTitle(engine.name)
		}
		
		// Set preferences to WebView
		dictionaryWebView.preferencesIdentifier = "dictionary"
		imageWebView.preferencesIdentifier = "image"
		dictionaryWebView.preferences.javaScriptEnabled = false
		dictionaryWebView.preferences.loadsImagesAutomatically = false
	}
	
	// Get a selected search engine for dictionary
	private func getSearchEngine() -> SearchEngine {
		return config.getSearchEngines()[searchEnginePopUpButton.indexOfSelectedItem]
	}
	
	// Get a selected image search engine
	private func getImageSearchEngine() -> SearchEngine {
		return config.getImageSearchEngines()[imageSearchEnginePopUpButton.indexOfSelectedItem]
	}
	
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
