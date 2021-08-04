//
//  ViewController.swift
//  MovieFlix
//
//  Created by Karrar Abd Ali on 03/08/2021.
//  Copyright © 2021 Karrar Abd Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        APIClient.shared.getHomePageMovies(completion: { result in
            switch result {
                
            case .success(let movieObject):
                print(movieObject.results?.count ?? "Nil")
            case .failure(let error):
                print(error)
            }
        })
    }


}

