//
//  LunchError.swift
//  BRTakeHome
//
//  Created by Tanner Perry on 2/10/22.
//

import Foundation
enum WSError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        
        case .invalidURL:
            return "The server failed to reach the url"
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -- \(error)"
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "Unable to decode data"
        }
    }
}

