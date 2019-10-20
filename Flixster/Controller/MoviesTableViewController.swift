//
//  MoviesViewController.swift
//  Flixster
//
//  Created by Julio Cesar Whatley on 10/18/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class MoviesTableViewController: UIViewController {
    
    var movies = [Result]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TheMoviedbClient.getMovies(completion: handleGetMovies(results:error:))
    }
    
    private func handleGetMovies(results: [Result], error: Error?) {
        if let error = error {
            print(error);
        } else {
            movies = results
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension MoviesTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movie = movies[(indexPath as NSIndexPath).row]
        
//        let baseUrl = "https://image.tmdb.org/t/p/w185" + movie.posterPath
        let posterUrl = TheMoviedbClient.getImgUrl(imgSize: "w185", imgPath: movie.posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl)
        cell.titleLabel.text = movie.title
        cell.synopsisLabel.text = movie.overview
        
        return cell
    }
}
