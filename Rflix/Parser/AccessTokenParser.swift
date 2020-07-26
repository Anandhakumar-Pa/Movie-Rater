//
//  AccessTokenParser.swift
//  Rflix
//
//  Created by Anandhakumar on 7/16/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import Foundation

var ACCESS_TOKEN = ""
var ACCESS_TOKEN_EXPIRE = ""

class AccessTokenParser: NSObject {
	class func parseAccessToken(_ responseData:Data) {
		do {
			let json = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions())
			guard let jsonDic = json as? [String: Any] else {
				return
			}
			if let status = jsonDic["success"] as? Bool, status != true {
				return
			}
			if let request_token = jsonDic["request_token"] as? String {
				ACCESS_TOKEN = request_token
			}
			if let expires_at = jsonDic["expires_at"] as? String {
				ACCESS_TOKEN_EXPIRE = expires_at
			}
			
		} catch {
			print(error.localizedDescription)
		}
	}
}
