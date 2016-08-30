//
//  PreferencesViewController.swift
//  VisualDictionary
//
//  Created by apple on 2016/08/30.
//  Copyright © 2016 Kenta Motomura. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSViewController {
	// UI
	@IBOutlet weak var speechCheckboxButton: NSButton!
	
	//============================================================
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Setup UI
		speechCheckboxButton.state = Int(Config.speech)
	}
	
	//============================================================
	@IBAction func onPushSpeechCheckbox(sender: AnyObject) {
		Config.speech = (speechCheckboxButton.state != 0)
	}
}
