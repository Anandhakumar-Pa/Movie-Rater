//
//  SecondViewController.swift
//  Rflix
//
//  Created by Anandhakumar on 7/14/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate {

	@IBOutlet weak var searchBar:UISearchBar!
	@IBOutlet weak var movieTableView:UITableView!
	var moviesList:[Movie]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(getSearchResult), object: nil)
		self.perform(#selector(getSearchResult), with: nil, afterDelay: 0.5)
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
}

extension SearchViewController:SearchServiceDelegate{
	func searchServiceSuccess(_ moviesList: [Movie]) {
		print(moviesList.count)
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
