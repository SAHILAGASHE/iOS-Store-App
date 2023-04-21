//
//  Product.swift
//  Store-App
//
//  Created by Sahil Agashe on 06/04/23.
//

import Foundation

struct Product: Codable {
    var id: Int?
    let title: String
    let price: Double
    let description: String
    let images: [URL]?
    let category: Category
}
