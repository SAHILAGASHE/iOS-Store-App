//
//  StoreHTTPClient.swift
//  Store-App
//
//  Created by Sahil Agashe on 05/04/23.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidServerResponse
    case decodingError
}

enum HttpMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete

    var name: String {
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .delete:
                return "DELETE"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var headers: [String: String] = [:]
    var method: HttpMethod = .get([])
}
class StoreHTTPClient {
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
            
            var request = URLRequest(url: resource.url)
            
            switch resource.method {
                case .get(let queryItems):
                    var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: true)
                    components?.queryItems = queryItems
                    guard let url = components?.url else {
                        throw NetworkError.invalidURL
                    }
                    
                    request = URLRequest(url: url)
                case .post(let data):
                    request.httpBody = data
                default: break
            }
            
            request.allHTTPHeaderFields = resource.headers
            request.httpMethod = resource.method.name
            
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
            
            let session = URLSession(configuration: configuration)
            
            let (data, response) = try await session.data(for: request)
            guard let _ = response as? HTTPURLResponse
            else {
                throw NetworkError.invalidServerResponse
            }
            
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                throw NetworkError.decodingError
            }
            
            return result
        }
    

    
    // MARK: - Following functions are implemented by sahil for only learning purpose , not used in further logic.
    
    func getProductsByCategory(categoryId: Int) async throws -> [Product] {
        
        let (data, response) = try await URLSession.shared.data(from: URL.productsByCategory(categoryId))
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidServerResponse
        }
        
        guard let products = try? JSONDecoder().decode([Product].self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return products
    }
    
    func getAllCategories() async throws -> [Category] {
        
        let (data, response) = try await URLSession.shared.data(from: URL.allCategories)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidServerResponse
        }
        
        guard let categories = try? JSONDecoder().decode([Category].self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return categories
    }
    
    func createProduct(productRequest: CreateProductRequest) async throws -> Product {
        
        var request = URLRequest(url: URL.createProduct)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(productRequest)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 201
        else {
            print("error ala be here http response madhe")
            throw NetworkError.invalidServerResponse
        }
        
        guard let product = try? JSONDecoder().decode(Product.self, from: data) else {
            print("erro alabe here http data decode kartani")
            throw NetworkError.decodingError
        }
        
        return product
    }
    
    func deleteProduct(productId: Int) async throws -> Bool {
        
        var request = URLRequest(url: URL.deleteProduct(productId))
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidServerResponse
        }
        
        let isDeleted = try JSONDecoder().decode(Bool.self, from: data)
        return isDeleted
    }
    
    
}

