//
//  AppDelegate.swift
//  Rflix
//
//  Created by Anandhakumar on 7/14/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window:UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		if TMDB_API_KEY.isEmpty {
			fatalError("Please insert your TMDB movie API Key")
		}
		return true
	}
}

