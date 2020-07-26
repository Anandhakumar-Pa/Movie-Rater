//
//  NetworkManager.swift
//  Rflix
//
//  Created by Anandhakumar on 7/15/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate {
	func dataAccessCompletedWithResponse(responseData data:Data, urlResponse urlresponse:HTTPURLResponse)
	func dataAccessFailed(errorMsg errorString:String)
}

class NetworkManager: NSObject,URLSessionDelegate {
	
	var delegate:NetworkManagerDelegate!
	
	func initWithUrlrequest(request urlRequest:NSMutableURLRequest){
		
		let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
		
		let networkTask = session.dataTask(with: urlRequest as URLRequest) { (data, urlResponse, error) in
			
			DispatchQueue.main.async {
				
				if error != nil {
					
					print("Network error:-- \(String(describing: error?.localizedDescription))")
					
					self.delegate.dataAccessFailed(errorMsg: error?.localizedDescription ?? NSLocalizedString("Service_Failer", comment: ""))
					
				}else {
					
					if let responseData = data { //responseData.count > 0 {
						
						print("Response string:-- \(String(describing: String(data: responseData, encoding: String.Encoding.utf8)))")
						
						let urlResponse = urlResponse as! HTTPURLResponse
						
						self.delegate.dataAccessCompletedWithResponse(responseData: responseData, urlResponse: urlResponse)
						
					}
					else {
						
						self.delegate.dataAccessFailed(errorMsg:NSLocalizedString("Service_Failer", comment: ""))
						
					}
				}
			}
			
		}
		
		networkTask.resume()
	}
}
