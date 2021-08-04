//
//  ViewController.swift
//  MovieFlix
//
//  Created by Karrar Abd Ali on 04/08/2021.
//  Copyright © 2021 Karrar Abd Ali. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var isWatchedButton: UIButton!
    @IBOutlet weak var movieDetailsTextView: UITextView!
    
    var movieState: Bool {
        get {
            return getState()
        }
        set {}
    }
    var movie: Movie?
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
        
    }
    
    
    private func fillData() {
        guard let movie = movie else {return}
        
        movieImageView.load(url: movie.posterPath ?? "")
        movieNameLabel.text = movie.originalTitle
        releaseDateLabel.text = DateHelper().stringISOStringReleased(dateString: movie.releaseDate)
        movieDetailsTextView.text = movie.overview
        
        isWatchedButton.setTitle(movieState ? "Watched": "Not Watched", for: .normal)
        view.backgroundColor = Constants.Colors.backgroundColor
    }
    
    @IBAction func didWatchClicked(_ sender: Any) {
        if let movie = movie, let id = movie.id {
            movieState = !(movieState)
            UserDefaults.standard.set(movieState, forKey: String(id))
            isWatchedButton.setTitle(movieState ? "Watched": "Not Watched", for: .normal)
        }
        
    }
    
    private func getState() -> Bool {
        if let movie = movie, let id = movie.id {
            let isWatched = UserDefaults.standard.bool(forKey: String(id))
            return isWatched
        } else {
            return false
        }
    }
}
