//
//  MoviesCollectionViewController.swift
//  Flixster
//
//  Created by Julio Cesar Whatley on 10/20/19.
//  Copyright © 2019 Capi. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesCollectionViewController: UIViewController {
    
    var movies = [Result]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setCollectionLayout()
        TheMoviedbClient.getSuperheroeMovies(completion: handleGetMovies(results:error:))
    }
    
    private func handleGetMovies(results: [Result], error: Error?) {
        if let error = error {
            print(error);
        } else {
            movies = results
            self.collectionView.reloadData()
        }
    }
    
    private func setCollectionLayout() {
        let space: CGFloat = 2.0
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = space
        
        let width = (view.frame.size.width - space * 2.0) / 3.0
        layout.itemSize = CGSize(width: width, height: width * 3/2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension MoviesCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = movies[indexPath.item]
        
        let posterUrl = TheMoviedbClient.getImgUrl(imgSize: "w185", imgPath: movie.posterPath)
        
        cell.posterView.af_setImage(withURL: posterUrl)
        
        return cell
        
    }
}
