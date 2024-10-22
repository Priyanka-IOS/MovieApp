//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Priyanka Ghosh on 21/10/24.
//

import UIKit

// View Controller for displaying movie details
class MovieDetailViewController: UIViewController {
    
    // Movie data to be displayed
    var movie: MoviesModelData?
    
    // Outlets for UI components
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    // Lifecycle method called after the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieDeatilsData() // Load movie details into the UI
    }
    
    // Function to load and display movie details
    func loadMovieDeatilsData() {
        // Ensure movie data is available
        guard let movie = movie else { return }
        
        // Load poster image from URL
        if let url = URL(string: movie.poster) {
            // Use SDWebImage to set the image with a placeholder
            posterImgView.sd_setImage(with: url, placeholderImage: UIImage(named: Constants.placeholderImg))
        }
        
        // Set text for labels with movie details
        titleLabel.text = movie.title
        plotLabel.text = movie.plot
        castLabel.text = "Cast: " + movie.actors
        genreLabel.text = "Genre: " + movie.genre
        releaseDateLabel.text = "Released: " + movie.year
        ratingLabel.text = "Rating: " + (movie.ratings.first?.value ?? "N/A") // Display rating or "N/A" if not available
    }
}
