//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Priyanka Ghosh on 21/10/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: MoviesModelData?
    
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieDeatilsData()
    }
    func loadMovieDeatilsData() {
        guard let movie = movie else { return  }
        if let url = URL(string: movie.poster) {
            posterImgView.sd_setImage(with: url, placeholderImage: UIImage(named: Constants.placeholderImg))
        }
        titleLabel.text = movie.title
        plotLabel.text = movie.plot
        castLabel.text = "Cast: " + movie.actors
        genreLabel.text = "Genre: " + movie.genre
        releaseDateLabel.text = "Released: " + movie.year
        ratingLabel.text = "Rating: " + (movie.ratings.first?.value ?? "N/A")
    }
}
