//
//  URLs.swift
//  Rflix
//
//  Created by Anandhakumar on 7/15/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import Foundation

let MOVIE_POSTER_BASE_URL = "https://image.tmdb.org/t/p/w500"
let TMDb_BASE_URL = "https://api.themoviedb.org/3/"
let AUTHENTICATION_URL = TMDb_BASE_URL.appending("authentication/token/new?api_key=")
let LOGIN_URL = TMDb_BASE_URL.appending("authentication/token/validate_with_login?api_key=")
let SEARCH_URL = TMDb_BASE_URL.appending("search/movie?api_key=%@&query=%@")
let POPULAR_MOVIES_URL = TMDb_BASE_URL.appending("movie/popular?api_key=")
let TOP_RATED_MOVIES_URL = TMDb_BASE_URL.appending("movie/top_rated?api_key=")
let RATE_MOVIE_URL = TMDb_BASE_URL.appending("movie/%@/rating?api_key=%@")
let RECOMMENDATION_URL = TMDb_BASE_URL.appending("movie/1/recommendations?api_key=")
let MOVIE_DETAILS_URL = TMDb_BASE_URL.appending("movie/%@?api_key=")
let GET_MY_RATINGS_URL = TMDb_BASE_URL.appending("account/%@/rated/movies?api_key=%@&sort_by=created_at.asc")
