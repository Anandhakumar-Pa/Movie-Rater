//
//  SecondViewController.swift
//  Rflix
//
//  Created by Anandhakumar on 7/14/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import UIKit
import HCSStarRatingView

class SearchViewController: UIViewController,UISearchBarDelegate {

	@IBOutlet weak var searchBar:UISearchBar!
	@IBOutlet weak var movieTableView:UITableView!
	var searchResult:[Movie] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		movieTableView.isHidden = true
		movieTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
		// Do any additional setup after loading the view.
	}
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(getSearchResult), object: nil)
		self.perform(#selector(getSearchResult), with: nil, afterDelay: 0.5)
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.view.endEditing(true)
	}
	
	@objc func getSearchResult() {
		guard let searchText = searchBar.text else { return	 }
		if !searchText.isEmpty {
			print("search movie call")
			let searchService = SearchServiceController()
			searchService.serviceDelegate = self
			searchService.getSearchResultsForGivenParam(searchText)
		}
	}
	@objc func ratingChanged(_ sender:HCSStarRatingView){
		let movie = searchResult[sender.tag]
		let authenticationService = RflixServiceController()
		authenticationService.serviceRequestType = .RATE_A_MOVIE
		authenticationService.rateMovie("\(movie.id)", rating: Double(sender.value))
	}
	
}

extension SearchViewController:SearchServiceDelegate{
	func searchServiceSuccess(_ moviesList: [Movie]) {
		DispatchQueue.main.async {
			self.movieTableView.isHidden = false
			self.searchResult = moviesList
			self.movieTableView.reloadData()
		}
	}
	func searchServiceFailed(errorMsg errorString: String) {
		print(errorString)
	}
}

extension SearchViewController:UITableViewDelegate, UITableViewDataSource {
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
		cell.ratingView.isUserInteractionEnabled = false
		return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//		let movie = moviesList[indexPath.row]
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let detailController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
		self.navigationController?.pushViewController(detailController, animated: true)
		
	}
}
