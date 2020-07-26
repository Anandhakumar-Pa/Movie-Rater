//
//  MoviesListViewController.swift
//  Rflix
//
//  Created by Anandhakumar on 7/21/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import UIKit
import HCSStarRatingView

let cellIdentifier = "MovieListCell"

class MoviesListViewController: UIViewController {

	@IBOutlet weak var titleLbl:UILabel!
	@IBOutlet weak var movieTableView:UITableView!
	var moviesList:[Movie]!
	var titleString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
		titleLbl.text = titleString
		movieTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        // Do any additional setup after loading the view.
	}
	
	@IBAction func backBtnClicked(_ sender:UIButton){
		self.navigationController?.popViewController(animated: true)
	}
	@IBAction func filterBtnClicked(_ sender:UIButton){
		print("filter by genere")
	}
	
	@objc func ratingChanged(_ sender:HCSStarRatingView){
		let movie = moviesList[sender.tag]
		print("Changed rating to ", sender.value)
		
		let authenticationService = RflixServiceController()
		authenticationService.serviceDelegate = self
		authenticationService.serviceRequestType = .RATE_A_MOVIE
		authenticationService.rateMovie("\(movie.id)", rating: Double(sender.value))
	}
}

extension MoviesListViewController:UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return moviesList.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieListCell
		let movie = moviesList[indexPath.row]
		cell.updateUI(movie)
		cell.ratingView.tag = indexPath.row
		cell.ratingView.addTarget(self, action: #selector(ratingChanged(_:)), for: UIControl.Event.valueChanged)
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		let movie = moviesList[indexPath.row]
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let detailController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
		self.navigationController?.pushViewController(detailController, animated: true)
		
	}
}
extension MoviesListViewController:RflixServiceDelegate {
	func tmdbServiceSuccess() {
		print("Rating success")
	}
	
	func discoverMoviesServiceSuccess(_ moviesList: [Movie], serviceCallBack reqeusType: TMDb_SERVICE_TYPE) {
		
	}
	
	func tmdbServiceFailed(errorMsg errorString: String) {
		print(errorString)
	}
	
	
}
