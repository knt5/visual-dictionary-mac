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
	@IBOutlet weak var splitView: NSSplitView!
	
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
		Config.getSearchEngines().forEach { (engine : SearchEngine) -> () in
			searchEnginePopUpButton.addItemWithTitle(engine.name)
		}
		
		// Add image search engines to PopUpButton
		Config.getImageSearchEngines().forEach { (engine : SearchEngine) -> () in
			imageSearchEnginePopUpButton.addItemWithTitle(engine.name)
		}
		
		//============================================================
		// Setup autosave
		
		// Split view's divider position
		splitView.autosaveName = "splitView"
		
		//============================================================
		// Set preferences of WebView
		
		// Set preferences ID to separate preferences of WebViews
		dictionaryWebView.preferencesIdentifier = "dictionary"
		imageWebView.preferencesIdentifier = "image"
		
		// Set preferences to block Ads
		updateDictionaryWebViewOptions()
		
		//============================================================
		// Store to App
		App.setViewController(self)
	}
	
	//============================================================
	override func viewWillAppear() {
		super.viewWillAppear()
		
		// Get main window
		let window: NSWindow = self.view.window!
		
		// Store to App
		App.setMainWindow(window)
		
		// Set window size
		resizeWindow(window, width: Config.mainWindowFrame.size.width, height: Config.mainWindowFrame.size.height)
		
		// Organize window position
		let screen: NSScreen = window.screen!
		let screenHeight: CGFloat = screen.frame.size.height
		let menuHeight: CGFloat = screenHeight - (screen.visibleFrame.origin.y + screen.visibleFrame.size.height)
		if (screenHeight - (window.frame.origin.y + window.frame.size.height) < menuHeight) {
			window.cascadeTopLeftFromPoint(NSMakePoint(window.frame.origin.x, menuHeight))
		}
	}
	
	//============================================================
	internal func updateDictionaryWebViewOptions() {
		if (Config.adBlcok == true) {
			dictionaryWebView.preferences.javaScriptEnabled = false
			dictionaryWebView.preferences.loadsImagesAutomatically = false
		} else {
			dictionaryWebView.preferences.javaScriptEnabled = true
			dictionaryWebView.preferences.loadsImagesAutomatically = true
		}
	}
	
	//============================================================
	private func resizeWindow(window: NSWindow, width: CGFloat, height: CGFloat) {
		// Get config
		var frame: NSRect = Config.mainWindowFrame
		
		// Set position to frame
		let x: CGFloat = window.frame.origin.x
		let y: CGFloat = window.frame.origin.y
		frame.origin.x = x
		frame.origin.y = y
		
		// Set size to frame
		frame.size.width = width
		frame.size.height = height
		
		// Set frame to window
		window.setFrame(frame, display: window.visible)
	}
	
	//============================================================
	// Get selected search engine for dictionary
	private func getSearchEngine() -> SearchEngine {
		return Config.getSearchEngines()[searchEnginePopUpButton.indexOfSelectedItem]
	}
	
	//============================================================
	// Get selected image search engine
	private func getImageSearchEngine() -> SearchEngine {
		return Config.getImageSearchEngines()[imageSearchEnginePopUpButton.indexOfSelectedItem]
	}
	
	//============================================================
	@IBAction func onSearchAction(sender: AnyObject) {
		if (searchField.stringValue.characters.count > 0) {
			// Start speaking keyword (Recommended speech voice is "Samantha")
			if (Config.speech) {
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
