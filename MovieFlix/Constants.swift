//
//  Constants.swift
//  MovieFlix
//
//  Created by Karrar Abd Ali on 03/08/2021.
//  Copyright © 2021 Karrar Abd Ali. All rights reserved.
//

import Foundation

struct Constants {
    // MARK: -API
    struct API {
        static let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
        static let baseUrl = "https://api.themoviedb.org/3/"
        static let HomePageMoviesURL = "movie/550?api_key={apiKey}"
        static let searchQuereyURL = "search/movie?api_key={apiKey}&language=en-US&query={MovieName}&page=1"//&include_adult=false
        
    }
    
}
