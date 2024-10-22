//
//  MoviesTableViewCell.swift
//  MoviesApp
//
//  Created by Priyanka Ghosh on 21/10/24.
//

import UIKit

// Custom UITableViewCell for displaying movie information
class MoviesTableViewCell: UITableViewCell {

    // Outlets for UI components in the cell
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieReleaseYearLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var moviesImgView: UIImageView!
    
    // Lifecycle method called when the cell is loaded from the storyboard
    override func awakeFromNib() {
        super.awakeFromNib()
        // Customize container view's appearance
        containerView.layer.borderColor = UIColor.separator.cgColor // Set border color
        containerView.layer.borderWidth = 1.0 // Set border width
        containerView.layer.cornerRadius = 8.0 // Set corner radius for rounded edges
    }
}
