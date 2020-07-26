//
//  MovieCell.swift
//  Rflix
//
//  Created by Anandhakumar on 7/19/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import UIKit
import HCSStarRatingView
import SDWebImage
class MovieCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	@IBOutlet weak var moviePoster:UIImageView!
	@IBOutlet weak var titleLbl:UILabel!
	@IBOutlet weak var releasedate:UILabel!
	@IBOutlet weak var ratingView:HCSStarRatingView!
	
	var movie: Movie?{
		didSet{
//			self.updateUI()
		}
	}
	func updateUI(){
		guard let movie = movie, let url = URL(string: MOVIE_POSTER_BASE_URL.appending(movie.posterPath)) else {
			return
		}
		moviePoster.sd_setImage(with: url, completed: nil)
		titleLbl.text = movie.title
		ratingView.value = CGFloat(ceil(movie.rating)/2)
		releasedate.text = RFDateFormatter.formatDate(date: movie.releaseDate)
	}

}
