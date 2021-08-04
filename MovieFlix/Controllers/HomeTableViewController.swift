//
//  ViewController.swift
//  MovieFlix
//
//  Created by Karrar Abd Ali on 03/08/2021.
//  Copyright © 2021 Karrar Abd Ali. All rights reserved.
//

import UIKit

class HomeTableViewController: UIViewController {
    //MARK:- Var
    @IBOutlet weak var tableView: UITableView!
    private var movies: [Movie]? = []
    @IBOutlet weak var searchBar: UISearchBar!
    private let homeTableViewCellIdentifier = "HomePageMovieTableViewCell"
    
    private var searchedMovies:[Movie] = []
    private var isSearching: Bool = false
    
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupSearchBar()
        loadData()
    }
        
    //MARK: - Methods
    private func loadData() {
        APIClient.shared.getHomePageMovies(completion: { result in
            switch result {
                
            case .success(let movieObject):
                print(movieObject.results?.count ?? "Nil")
                self.movies = movieObject.results
                self.searchedMovies = movieObject.results ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: homeTableViewCellIdentifier, bundle: .main), forCellReuseIdentifier: homeTableViewCellIdentifier)
        tableView.separatorStyle = .none
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
    }
}

extension HomeTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchedMovies.count
        } else {
        return movies?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: homeTableViewCellIdentifier, for: indexPath) as? HomePageMovieTableViewCell
        
        let action:  (() -> Void) = {
            // Present detail View
            if let movies = self.movies {
                let movie = movies[indexPath.row]
                let vc = MovieDetailsViewController(movie: movie)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        let moviesArray = isSearching ? searchedMovies : self.movies
        guard  let movies = moviesArray, cell != nil else {return UITableViewCell()}
        let movie = movies[indexPath.row]
        cell?.infoButtonAction = action
        if let posterPath = movie.posterPath {
            cell?.movieImageView.load(url: posterPath)
        }
        cell?.movieNameLabel.text = movie.originalTitle
        cell?.releaseDateLabel.text = DateHelper().stringISOStringReleased(dateString: movie.releaseDate)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let movies = movies else { return }
        let movie = movies[indexPath.row]
        if let id = movie.id {
            let controller = WebViewController(movieId: id)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
}

extension HomeTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let movies = (self.movies != nil) ? self.movies! : []
        isSearching = !searchText.isEmpty
        if searchText.isEmpty {
            searchBar.resignFirstResponder()
        }
        searchedMovies = movies.filter({
            if let searched =  $0.originalTitle?.prefix(searchText.count), searched.lowercased() == searchText.lowercased() {
                return true
            }
            return false
        })
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.searchTextField.text, !text.isEmpty else {
            isSearching = false
            return
        }
        
        isSearching = true
            APIClient.shared.searchMovie(name: text, completion: { result in
                switch result {
                case .success(let movieObject):
                    self.movies?.append(contentsOf: movieObject.results ?? [])
                    self.searchedMovies.append(contentsOf: movieObject.results ?? [])
                    DispatchQueue.main.async {self.tableView.reloadData()}
                case .failure(let error): print(error)
                self.isSearching = false
                DispatchQueue.main.async {self.tableView.reloadData()}
                }
            })
    }
}
