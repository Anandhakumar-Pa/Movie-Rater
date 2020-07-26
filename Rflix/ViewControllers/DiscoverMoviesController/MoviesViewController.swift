//
//  FirstViewController.swift
//  Rflix
//
//  Created by Anandhakumar on 7/14/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import UIKit

let reuseIdentifier = "MovieCell"

class MoviesViewController: UIViewController {

	var popularMoviesList:[Movie] = [Movie]()
	var topMoviesList:[Movie] = [Movie]()
	@IBOutlet weak var popularMovieCollection:UICollectionView!
	@IBOutlet weak var topMoviesCollection:UICollectionView!
	
	private let sectionInsets = UIEdgeInsets(top: 50.0,
											 left: 20.0,
											 bottom: 50.0,
											 right: 20.0)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		popularMovieCollection.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
		topMoviesCollection.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
		getPopularMovies()
		getTopRatedMovies()
		// Do any additional setup after loading the view.
	}
	func getPopularMovies() {
		let authenticationService = RflixServiceController()
		authenticationService.serviceDelegate = self
		authenticationService.serviceRequestType = .POPULAR_MOVIES
		authenticationService.getDiscoverMovies(true)
	}
	func getTopRatedMovies() {
		let authenticationService = RflixServiceController()
		authenticationService.serviceDelegate = self
		authenticationService.serviceRequestType = .TOP_RATED_MOVIES
		authenticationService.getDiscoverMovies(false)
	}
	@IBAction func viewAllBtnClicked(_ sender:UIButton){
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let listController = storyboard.instantiateViewController(withIdentifier: "MoviesListViewController") as! MoviesListViewController
		if sender.tag == 1 {
			listController.titleString = "Popular movies"
			listController.moviesList = popularMoviesList
		}else if sender.tag == 2 {
			listController.titleString  = "Top rated movies"
			listController.moviesList = topMoviesList
		}
		self.navigationController?.pushViewController(listController, animated: true)
	}
	
}

extension MoviesViewController: RflixServiceDelegate {
	func tmdbServiceSuccess() {
		
	}
	func tmdbServiceFailed(errorMsg errorString: String) {
		print(errorString)
	}
	func discoverMoviesServiceSuccess(_ moviesList: [Movie], serviceCallBack reqeusType: TMDb_SERVICE_TYPE) {
		switch reqeusType {
			case .POPULAR_MOVIES:
				popularMoviesList = moviesList
				popularMovieCollection.reloadData()
				break
			case .TOP_RATED_MOVIES:
				topMoviesList = moviesList
				topMoviesCollection.reloadData()
				break
			default:
			break
		}
	}
}

extension MoviesViewController:UICollectionViewDelegate, UICollectionViewDataSource{
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MovieCell
		if collectionView == popularMovieCollection {
			let movie = popularMoviesList[indexPath.row]
			cell.movie = movie
			cell.updateUI()
		}else if collectionView == topMoviesCollection {
			let movie = topMoviesList[indexPath.row]
			cell.movie = movie
			cell.updateUI()
		}
		return cell
	}
	
	//UICollectionViewDelegateFlowLayout methods
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
	{
		
		return 4;
	}
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
	{
		
		return 1;
	}
	
	
	//UICollectionViewDatasource methods
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == popularMovieCollection {
			return popularMoviesList.count
		}else if collectionView == topMoviesCollection {
			return topMoviesList.count
		}
		return 1
	}
	
	
	// custom function to generate a random UIColor
	func randomColor() -> UIColor{
		let red = CGFloat(drand48())
		let green = CGFloat(drand48())
		let blue = CGFloat(drand48())
		return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
	}
}

extension MoviesViewController:UICollectionViewDelegateFlowLayout {
	//1
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		if collectionView == popularMovieCollection {
			return CGSize(width: 100, height: 150)
		}else if collectionView == topMoviesCollection {
			return CGSize(width: 100, height: 150)
		}
		return CGSize(width: 100, height: 150)
	}

}
