//
//  DeleteProductResponse.swift
//  Store-App
//
//  Created by Sahil Agashe on 13/04/23.
//

import Foundation

struct DeleteProductResponse: Decodable {
    var rta: Bool?
    var statusCode: Int?
    var message: String?
    var error: String?
}
