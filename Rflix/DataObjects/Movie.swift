//
//  Movie.swift
//  Rflix
//
//  Created by Anandhakumar on 7/19/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import Foundation
	
struct Movie:Codable {
	let id:Int
	let posterPath:String
	let title:String
	let releaseDate:String
	var rating:Double
	let backdrop:String!
	let overview:String
	
	private enum CodingKeys:String,CodingKey {
		case id,
		posterPath = "poster_path",
		title,
		releaseDate = "release_date",
		rating="vote_average",
		overview,
		backdrop = "backdrop_path"
	}
}

struct APIResults:Codable {
	let page:Int
	let numResults:Int
	let numPages:Int
	let movie:[Movie]
	
	private enum CodingKeys:String,CodingKey{
		case page,
		numResults = "total_results",
		numPages = "total_pages",
		movie = "results"
	}
	
}
