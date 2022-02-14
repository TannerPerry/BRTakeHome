//
//  LunchService.swift
//  BRTakeHome
//
//  Created by Tanner Perry on 2/10/22.
//

import UIKit

protocol LunchServiceProtocol {
    func fetchRestaurants(completion: @escaping (Result<[Restaurant], WSError>) -> Void)
    func fetchRestaurantImage(restaurant: Restaurant, completion: @escaping (Result<UIImage, WSError>) -> Void )
}

class LunchService : LunchServiceProtocol {
    
    private let baseURL = URL(string: "https://s3.amazonaws.com/br-codingexams/restaurants.json")
    private let imageService : ImageServiceProtocol
    
    public init(imageService:ImageServiceProtocol) {
        self.imageService = imageService
    }
    
    func fetchRestaurants(completion: @escaping (Result<[Restaurant], WSError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: baseURL) { data, _, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let restaurants = try JSONDecoder().decode(RestaurantList.self, from: data)
                return completion(.success(restaurants.restaurants))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    
    func fetchRestaurantImage(restaurant: Restaurant, completion: @escaping (Result<UIImage, WSError>) -> Void ) {
        
        // Check to see if our image is already cached
        if let image = imageService.getImage(withName: restaurant.name) {
            return completion(.success(image))
        }
        
        // Didn't find the image, get the url and go fetch it
        guard let imageURL = URL(string: restaurant.backgroundImageURL) else { return completion(.failure(.invalidURL)) }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            // Decode our image data
            guard let image = UIImage(data: data) else{
                return completion(.failure(.unableToDecode))
            }
            
            // Got an image, cache it, then return it
            self.imageService.cache(image: image, withName: restaurant.name)
            return completion(.success(image))
            
        }.resume()
    }
}
