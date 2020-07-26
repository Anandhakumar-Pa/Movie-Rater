//
//  MovieListCell.swift
//  Rflix
//
//  Created by Anandhakumar on 7/21/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import UIKit
import HCSStarRatingView

let cellIdentifier = "MovieListCell"

class MovieListCell: UITableViewCell {

	@IBOutlet weak var moviePoster:UIImageView!
	@IBOutlet weak var titleLbl:UILabel!
	@IBOutlet weak var releasedate:UILabel!
	@IBOutlet weak var ratingView:HCSStarRatingView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
	func updateUI(_ movie:Movie){
		guard let posterPath = movie.posterPath, let url = URL(string: MOVIE_POSTER_BASE_URL.appending(posterPath)) else {
			return
		}
		moviePoster.sd_setImage(with: url, completed: nil)
		titleLbl.text = movie.title
		ratingView.value = CGFloat(ceil(movie.rating)/2)
		releasedate.text = "Released on: ".appending(RFDateFormatter.formatDate(date: movie.releaseDate))
	}
}
