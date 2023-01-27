//
//  APIRouter.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import Foundation

enum APIRouter {

    case Recipes
    
    private var method: HTTPMethod {
        switch self {
        case .Recipes:
            return .GET
        }
    }

    private var path: String {
        switch self {
        case .Recipes:
            return "complexSearch?apiKey=6ef88bbedd664620888ff1af91097df8"
        }
    }

    private var url: String {
        APIManagerConstants.endpoint
    }

    private var urlRequest: URLRequest? {
        guard let url = URL(string: url) else {
            return nil
        }
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = APIManager.defaultHeaders as? [String: String]
        return urlRequest
    }

    private var nsUrlRequest: URLRequest? {
        guard let nsUrl = NSURL(string: self.url + path) else {
            return nil
        }
        var urlRequest = URLRequest(url: nsUrl as URL)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = APIManager.defaultHeaders as? [String: String]
        return urlRequest
    }

    var request: URLRequest? {
        switch self {
        case .Recipes:
            return nsUrlRequest
        }
    }

}

