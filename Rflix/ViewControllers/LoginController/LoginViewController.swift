//
//  LoginViewController.swift
//  Rflix
//
//  Created by Anandhakumar on 7/15/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

	@IBOutlet weak var userNameText:UITextField!
	@IBOutlet weak var passwordText:UITextField!
	@IBOutlet weak var loginBtn:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
		userNameText.text = "margianand"
		passwordText.text = "Qatar@123"
		callAuthenticationService()
        // Do any additional setup after loading the view.
    }
	
	@IBAction func loginBtnClicked(_ sender:UIButton){
		var errorMessage = ""
		if userNameText.text!.isEmpty {
			errorMessage = "Please enter your username/email"
		}
		if passwordText.text!.isEmpty {
			errorMessage = errorMessage.appending("\nPlease enter your password")
		}
		print(errorMessage)
		if errorMessage.isEmpty {
			self.view.endEditing(true)
			createLoginSession()
		}
	}
	
	func callAuthenticationService() {
		let authenticationService = RflixServiceController()
		authenticationService.serviceDelegate = self
		authenticationService.serviceRequestType = .AUTHENTICATION_SERVICE
		authenticationService.getAuthenticationToken()
	}
	
	func createLoginSession() {
		let authenticationService = RflixServiceController()
		authenticationService.serviceDelegate = self
		authenticationService.serviceRequestType = .LOGIN_SERVICE
		authenticationService.getAuthenticationToken()
	}
}

extension LoginViewController :UITextFieldDelegate{
	
}

extension LoginViewController:RflixServiceDelegate {
	func discoverMoviesServiceSuccess(_ moviesList: [Movie], serviceCallBack reqeusType: TMDb_SERVICE_TYPE) {
	}
	
	
	func tmdbServiceSuccess(){
		print("tmdbServiceSuccess")
		loadDiscoverMoviesController()
		
	}
	func tmdbServiceFailed(errorMsg errorString:String){
		print(errorString)
	}
	func loadDiscoverMoviesController(){
		let window = UIApplication.shared.delegate!.window!!
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let mainViewController = storyboard.instantiateViewController(withIdentifier: "navigationController")
		window.rootViewController = mainViewController //Setting viewController as rootviewController - Anand
		//Adding Animation on Splash screen with duration of 2.5
		
		UIView.transition(with: window, duration: 0, options: UIView.AnimationOptions.transitionCrossDissolve, animations: nil, completion: nil)
	}
}
