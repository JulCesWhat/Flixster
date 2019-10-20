//
//  MovieDetailsViewController.swift
//  Flixster
//
//  Created by Julio Cesar Whatley on 10/20/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: MovieResult!
    var movieVideos = [VideoResult]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let posterUrl = TheMoviedbClient.getImgUrl(imgSize: "w185", imgPath: movie.posterPath)
        posterView.af_setImage(withURL: posterUrl)
        
        let backdropUrl = TheMoviedbClient.getImgUrl(imgSize: "w780", imgPath: movie.backdropPath)
        backdropView.af_setImage(withURL: backdropUrl)
        
        titleLabel.text = movie.title
        synopsisLabel.text = movie.overview
    }

    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        print("I am being called....")
        if (movieVideos.count < 1) {
            TheMoviedbClient.getMovieVideo(videoId: movie.id, completion: handleGetMovieVideo(results:error:))
        }
    }
    
    private func handleGetMovieVideo(results: [VideoResult], error: Error?) {
        if let error = error {
            print(error);
        } else {
            movieVideos = results
            
            performSegue(withIdentifier: "videoSegue", sender: nil)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieVideoViewController = segue.destination as! MovieVideoViewController
        
        movieVideoViewController.videoUrl = "https://www.youtube.com/watch?v=\(movieVideos[0].key)"
    }

}
