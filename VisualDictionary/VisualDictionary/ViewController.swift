//
//  ViewController.swift
//  VisualDictionary
//
//  Created by apple on 2016/08/19.
//  Copyright © 2016年 Kenta Motomura. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
	@IBOutlet var mainView: NSView!
	@IBOutlet weak var searchField: NSSearchField!
	@IBOutlet weak var searchEnginePopUpButton: NSPopUpButton!
	@IBOutlet weak var imageSearchEnginePopUpButton: NSPopUpButton!
	
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
	}
	
}
