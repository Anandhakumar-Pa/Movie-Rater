//
//  MovieDetailViewController.swift
//  Rflix
//
//  Created by Anandhakumar on 7/21/20.
//  Copyright © 2020 Anandhakumar. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

	@IBOutlet weak var titleLbl:UILabel!
	var titleString = ""
	
    override func viewDidLoad() {
        super.viewDidLoad()
		titleLbl.text = titleString
        // Do any additional setup after loading the view.
    }
	
	@IBAction func backBtnClicked(_ sender:UIButton){
		self.navigationController?.popViewController(animated: true)
	}
}
