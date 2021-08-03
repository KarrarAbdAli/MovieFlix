//
//  APIClient.swift
//  MovieFlix
//
//  Created by Karrar Abd Ali on 03/08/2021.
//  Copyright © 2021 Karrar Abd Ali. All rights reserved.
//

import Foundation

class APIClient {
    //MARK:- Var
    static let shared = APIClient()
    
    //MARK:- Methods
    func getHomePageMovies(completion: @escaping (Result<MoviesObject, Error>) -> Void ) {
        let urlString = (Constants.API.baseUrl + Constants.API.HomePageMoviesURL.replacingOccurrences(of: "{apiKey}", with: Constants.API.apiKey)).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print("### URL: ", urlString ?? "")
        if let urlString = urlString, let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(String(describing: error))
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let decodedData = try decoder.decode(MoviesObject.self, from: data)
                    completion(.success(decodedData))
                } catch let error {
                    print(error)
                    completion(.failure(error))
                }

                print(String(data: data, encoding: .utf8) ?? "")
            }
            
            task.resume()
        }
    }
    
    func searchMovie(name: String, completion: @escaping (Result<MoviesObject, Error>) -> Void) {
        let urlString = (Constants.API.baseUrl + Constants.API.searchQuereyURL.replacingOccurrences(of: "{apiKey}", with: Constants.API.apiKey).replacingOccurrences(of: "{MovieName}", with: name)).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        print("### URL: ", urlString ?? "")
        guard let urlStringValue = urlString,
            let url = URL(string: urlStringValue),
            !name.isEmpty else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(MoviesObject.self, from: data)
                completion(.success(decodedData))
            } catch let error {
                print(error)
                completion(.failure(error))
            }
            print(String(data: data, encoding: .utf8) ?? "")
        }
        task.resume()
    }
}

