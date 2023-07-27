//
//  APIError.swift
//  MovieFanPersistance
//
//  Created by Avinash Kumar on 27/07/23.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case urlSession(URLError?)
    case badResponse(Int)
    case decoding(DecodingError?)
    case unknown
    
    public var description: String{
        switch self {
           case .badURL:
               return "badURL"
           case .urlSession(let error):
               return "urlSession error: \(error.debugDescription)"
           case .badResponse(let statusCode):
               return "bad response with status code: \(statusCode)"
           case .decoding(let decodingError):
               return "decoding error: \(String(describing: decodingError))"
           case .unknown:
               return "unknown error"
        }
    }
    
    public var localizedDescription: String {
        switch self {
            case .badURL, .unknown:
               return "something went wrong"
            case .urlSession(let urlError):
                return urlError?.localizedDescription ?? "something went wrong"
            case .badResponse(_):
                return "bad response"
            case .decoding(let decodingError):
                return decodingError?.localizedDescription ?? "decoding error"
        }
    }
    
}
