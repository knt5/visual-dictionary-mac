//
//  SearchEngine.swift
//  VisualDictionary
//
//  Created by apple on 2016/08/23.
//  Copyright © 2016 Kenta Motomura. All rights reserved.
//

import Foundation

class SearchEngine {
	let name: String
	let url: String
	let id: String
	
	init(name: String, url: String, id: String = "") {
		self.name = name
		self.url = url
		self.id = id
	}
}
