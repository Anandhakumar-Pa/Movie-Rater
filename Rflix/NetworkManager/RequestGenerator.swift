//
//  RequestGenerator.swift
//  Rflix
//
//  Created by Anandhakumar on 7/15/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import Foundation

enum HTTP_METHOD:String {
	case POST,GET
}
enum CONTENT_TYPE:String {
	case TEXT = "text/plain",JSON = "application/json"
}
struct RequestWrapper {
	var requestMethod = HTTP_METHOD.POST.rawValue
	var headerFields:[String:String]!
	var requestBody : Data!
	
}

class RequestGenerator: NSObject {
	
	class func createRequestWithURL(urlString url:String, timoutInterval interval:TimeInterval, wrapper requestWrapper:RequestWrapper)->NSMutableURLRequest{
		
		let request = NSMutableURLRequest.init(url: URL(string: url)!, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: interval)
		
		if let requestHeader = requestWrapper.headerFields {
			print("Request header fileds \(requestHeader)")
			request.allHTTPHeaderFields = requestHeader
		}
		
		request.httpMethod = requestWrapper.requestMethod
		
		print("Request url " + url)
		
		if let requestBody = requestWrapper.requestBody {
			print("Request body ")
			print(String(data: requestWrapper.requestBody, encoding: String.Encoding.utf8) ?? " ")
			request.httpBody = requestBody
		}
		
		return request
	}
}
