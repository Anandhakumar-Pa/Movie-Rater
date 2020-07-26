//
//  RflixServiceController.swift
//  Rflix
//
//  Created by Anandhakumar on 7/15/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import Foundation

protocol RflixServiceDelegate {
	func tmdbServiceSuccess()
	func discoverMoviesServiceSuccess(_ moviesList:[Movie], serviceCallBack reqeusType:TMDb_SERVICE_TYPE)
	func tmdbServiceFailed(errorMsg errorString:String)
}

class RflixServiceController: NSObject {
	
	var serviceDelegate:RflixServiceDelegate!
	var serviceRequestType = TMDb_SERVICE_TYPE.NONE
	
	func createNetworkManager(_ requestURl:String, withWrapper wrapper:RequestWrapper) {
		
		let urlReq = RequestGenerator.createRequestWithURL(urlString: requestURl, timoutInterval: Double.infinity, wrapper: wrapper)
		
		let networkManager = NetworkManager()
		networkManager.delegate = self
		networkManager.initWithUrlrequest(request: urlReq)
	}
	
	func getAuthenticationToken() {
		let requestURl = AUTHENTICATION_URL.appending(TMDB_API_KEY)
		
		var wrapper = RequestWrapper()
		wrapper.requestMethod = HTTP_METHOD.GET.rawValue
		
		createNetworkManager(requestURl,withWrapper: wrapper)
	}
	
	func createLoginSession(_ userName:String, withPassword password:String) {
		let requestURl = LOGIN_URL.appending(TMDB_API_KEY)
		
		var wrapper = RequestWrapper()
		wrapper.requestMethod = HTTP_METHOD.POST.rawValue
		
		let paramsDic = NSMutableDictionary()
		paramsDic.setValue(userName, forKey: "username")
		paramsDic.setValue(password, forKey: "password")
		paramsDic.setValue(ACCESS_TOKEN, forKey: "request_token")
		do {
			try wrapper.requestBody = JSONSerialization.data(withJSONObject: paramsDic, options: JSONSerialization.WritingOptions())
		} catch {
			print(error.localizedDescription)
		}
		
		createNetworkManager(requestURl,withWrapper: wrapper)
	}
	
	func getDiscoverMovies(_ isPopular:Bool) {
		var url = POPULAR_MOVIES_URL.appending(TMDB_API_KEY)
		if !isPopular {
			url = TOP_RATED_MOVIES_URL.appending(TMDB_API_KEY)
		}
		var wrapper = RequestWrapper()
		wrapper.requestMethod = HTTP_METHOD.GET.rawValue
	
		createNetworkManager(url,withWrapper: wrapper)
	}
	
	func rateMovie(_ id:String, rating rate:Double){
		
		let requestURl = String(format: RATE_MOVIE_URL, id,TMDB_API_KEY)
		
		var wrapper = RequestWrapper()
		
		wrapper.requestMethod = HTTP_METHOD.POST.rawValue
		
		let paramsDic = NSMutableDictionary()
		paramsDic.setValue(rate * 2, forKey: "value")
		do {
			try wrapper.requestBody = JSONSerialization.data(withJSONObject: paramsDic, options: JSONSerialization.WritingOptions())
		} catch {
			print(error.localizedDescription)
		}
		
		createNetworkManager(requestURl,withWrapper: wrapper)
	}
}

extension RflixServiceController:NetworkManagerDelegate{
	func dataAccessFailed(errorMsg errorString: String) {
		serviceDelegate.tmdbServiceFailed(errorMsg: errorString)
	}
	
	func dataAccessCompletedWithResponse(responseData data: Data, urlResponse urlresponse: HTTPURLResponse) {
		if urlresponse.statusCode == 200, serviceDelegate != nil {
			switch serviceRequestType {
				case .AUTHENTICATION_SERVICE:
					serviceDelegate = nil
					AccessTokenParser.parseAccessToken(data)
				case .POPULAR_MOVIES,
					 .TOP_RATED_MOVIES:
					do {
						let result = try JSONDecoder().decode(APIResults.self, from: data)
						serviceDelegate.discoverMoviesServiceSuccess(result.movie,serviceCallBack: serviceRequestType)
					} catch {
						print(error)
					}
					
				break
				default:
					serviceDelegate.tmdbServiceSuccess()
				break
			}
		}else{
			serviceDelegate.tmdbServiceFailed(errorMsg: HTTPURLResponse.localizedString(forStatusCode: urlresponse.statusCode))
		}
	}
}
