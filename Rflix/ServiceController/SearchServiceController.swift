//
//  SearchServiceController.swift
//  Rflix
//
//  Created by Anandhakumar on 7/21/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import Foundation

protocol SearchServiceDelegate {
	func searchServiceSuccess(_ moviesList:[Movie])
	func searchServiceFailed(errorMsg errorString:String)
}

class SearchServiceController: NSObject {
	
	var serviceDelegate:SearchServiceDelegate!
	
	func getSearchResultsForGivenParam(_ param:String) {
		
		let requestURl = String(format: SEARCH_URL, TMDB_API_KEY,param)
		
		var wrapper = RequestWrapper()
		
		wrapper.requestMethod = HTTP_METHOD.GET.rawValue
		
		let urlReq = RequestGenerator.createRequestWithURL(urlString: requestURl, timoutInterval: Double.infinity, wrapper: wrapper)
		
		let networkManager = NetworkManager()
		networkManager.delegate = self
		networkManager.initWithUrlrequest(request: urlReq)
	}
	
	func getMyRatings() {
		
		let requestURl = String(format: GET_MY_RATINGS_URL, ACCESS_TOKEN,TMDB_API_KEY)
		
		var wrapper = RequestWrapper()
		
		wrapper.requestMethod = HTTP_METHOD.GET.rawValue
		
		let urlReq = RequestGenerator.createRequestWithURL(urlString: requestURl, timoutInterval: Double.infinity, wrapper: wrapper)
		
		let networkManager = NetworkManager()
		networkManager.delegate = self
		networkManager.initWithUrlrequest(request: urlReq)
	}
}

extension SearchServiceController:NetworkManagerDelegate{
	func dataAccessFailed(errorMsg errorString: String) {
		serviceDelegate.searchServiceFailed(errorMsg: errorString)
	}
	
	func dataAccessCompletedWithResponse(responseData data: Data, urlResponse urlresponse: HTTPURLResponse) {
		if urlresponse.statusCode == 200{
			do {
				let result = try JSONDecoder().decode(APIResults.self, from: data)
				serviceDelegate.searchServiceSuccess(result.movie)
			} catch {
				print(error)
			}
		}else{
			serviceDelegate.searchServiceFailed(errorMsg: HTTPURLResponse.localizedString(forStatusCode: urlresponse.statusCode))
		}
	}
}
