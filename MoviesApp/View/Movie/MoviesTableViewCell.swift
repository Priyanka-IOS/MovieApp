//
//  MoviesTableViewCell.swift
//  MoviesApp
//
//  Created by Priyanka Ghosh on 21/10/24.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieReleaseYearLbl: UILabel!
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var moviesImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.borderColor = UIColor.separator.cgColor
        containerView.layer.borderWidth = 1.0
        containerView.layer.cornerRadius = 8.0
    }
}
