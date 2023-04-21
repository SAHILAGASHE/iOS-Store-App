//
//  Double+Extensions.swift
//  Store-App
//
//  Created by Sahil Agashe on 13/04/23.
//

import Foundation

extension Double {
    
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: self)) ?? "0.00"
    }
    
}
