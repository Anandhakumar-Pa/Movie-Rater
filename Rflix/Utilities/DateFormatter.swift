//
//  DateFormatter.swift
//  Rflix
//
//  Created by Anandhakumar on 7/19/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import Foundation

class RFDateFormatter{
	static let dateFormatterInstance = DateFormatter()
	
	static func formatDate(date:String) -> String {
		dateFormatterInstance.dateFormat = "yyyy-MM-dd"
		guard let date = dateFormatterInstance.date(from: date) else { return "" }
		dateFormatterInstance.dateFormat = "yyyy"
		return dateFormatterInstance.string(from: date)
	}
}
