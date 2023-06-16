//
//  ViewController.swift
//  MyApp
//
//  Created by Vignesh Jeyaraj on 16/06/23.
//

import UIKit
import MySDK

class ViewController: UIViewController {
    private var api: MyAPI?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        api = MyAPI(token: "MyTokenGoesHere")
    }


}

