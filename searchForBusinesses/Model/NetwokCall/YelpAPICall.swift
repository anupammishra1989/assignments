//
//  YelpAPICall.swift
//  searchForBusinesses
//
//  Created by anupam mishra on 26/06/22.
//

import Foundation


enum URLError : Error {
    case badURL
}

class YelpAPICall: ObservableObject {
    
    enum LoadingState {
        case idle
        case loading
        case loaded(BusinessesResponse)
        case failed(Error)
    }
    
    @Published var state: LoadingState = .idle
    let token = "pVsDVsr01tInNWBJAzOVdpHXLziseRLVKuGw-FejC9RriegZt16nCOOg2_LJgw8fpaIarBcHbLKb80w4PGfr9imQTqI_mvLDWSWtqYlaIOquvzEt4Uxh5sq_Hfo0YXYx"
    
    func fetchBusinesse(term: String,
                        latitude: String,
                        longitude: String) async {
        // Create GET request
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search?")
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "latitude", value: latitude),
            URLQueryItem(name: "longitude", value: longitude)
        ]
        
        guard let urlComponents = urlComponents,
              let url = urlComponents.url else {
                  self.state = .failed(URLError.badURL)
                  return
              }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        self.state = .loading
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                self.state = .failed(error ?? URLError.badURL)
                return
            }
            if let jsonDecodable = try? JSONDecoder().decode(BusinessesResponse.self, from: data) {
                DispatchQueue.main.async {
                    print(jsonDecodable)
                    self.state = .loaded(jsonDecodable)
                }
            }
        }
        task.resume()
    }
}
