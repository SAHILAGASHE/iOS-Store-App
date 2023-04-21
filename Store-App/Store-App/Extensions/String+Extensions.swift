//
//  String+Extensions.swift
//  Store-App
//
//  Created by Sahil Agashe on 08/04/23.
//

import Foundation

extension String {
    
    var isNumeric: Bool {
        Double(self) != nil
    }
    
}
