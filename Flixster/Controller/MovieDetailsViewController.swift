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
    
    var movie: Result!

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
