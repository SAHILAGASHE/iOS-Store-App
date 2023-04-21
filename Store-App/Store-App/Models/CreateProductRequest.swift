//
//  CreateProductRequest.swift
//  Store-App
//
//  Created by Sahil Agashe on 09/04/23.
//

import Foundation

/*
 Created this structure according to "Create a Product" in website
 https://fakeapi.platzi.com/en/rest/products
 */

struct CreateProductRequest: Encodable {
    
    let title: String
    let price: Double
    let description: String
    let categoryId: Int
    let images: [URL]
    
    init(product: Product) {
        title = product.title
        price = product.price
        description = product.description
        categoryId = product.category.id
        images = product.images ?? []
    }
    
}
