//
//  MyRatingViewController.swift
//  Rflix
//
//  Created by Anandhakumar on 7/15/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import UIKit
import HCSStarRatingView

class MyRatingViewController: UIViewController {

	@IBOutlet weak var movieTableView:UITableView!
	var searchResult:[Movie] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		movieTableView.isHidden = true
		movieTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
		getSearchResult()
        // Do any additional setup after loading the view.
    }
    
	func getSearchResult() {
		let searchService = SearchServiceController()
		searchService.serviceDelegate = self
		searchService.getMyRatings()
	}
	@objc func ratingChanged(_ sender:HCSStarRatingView){
		let movie = searchResult[sender.tag]
		let authenticationService = RflixServiceController()
		authenticationService.serviceRequestType = .RATE_A_MOVIE
		authenticationService.rateMovie("\(movie.id)", rating: Double(sender.value))
	}
}

extension MyRatingViewController:SearchServiceDelegate{
	func searchServiceSuccess(_ moviesList: [Movie]) {
		DispatchQueue.main.async {
			self.movieTableView.isHidden = false
			self.searchResult = moviesList
			self.movieTableView.reloadData()
		}
	}
	func searchServiceFailed(errorMsg errorString: String) {
		print(errorString)
		movieTableView.isHidden = true
	}
}

extension MyRatingViewController:UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchResult.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieListCell
		let movie = searchResult[indexPath.row]
		cell.updateUI(movie)
		cell.ratingView.tag = indexPath.row
		cell.ratingView.addTarget(self, action: #selector(ratingChanged(_:)), for: UIControl.Event.valueChanged)
		return cell
	}
}
