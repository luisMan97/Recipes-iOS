//
//  APIManager.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import Foundation
import Combine

protocol APIManagerProtocol {
    func request<T: Decodable>(service: APIRouter) async throws -> T
}

class APIManager {

    static var defaultHeaders: NSMutableDictionary = [
        "Content-Type": "application/json"
    ]

}

// MARK: - Data Request Methods
extension APIManager: APIManagerProtocol {
    
    func request<T: Decodable>(service: APIRouter) async throws -> T {
        guard let request = service.request else {
            let error = NSError(domain: "error", code: 404, userInfo: [NSLocalizedDescriptionKey: "Bad URL"])
            throw error
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            let error = NSError(domain: "error", code: 0, userInfo: [NSLocalizedDescriptionKey: "StatusCode error"])
            throw error
        }
        guard statusCode == 200 else {
            let error = NSError(domain: "error", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "\(statusCode)"])
            throw error
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
}
