//
//  ViewController.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 03/06/24.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.view.backgroundColor = .purple
        // Do any additional setup after loading the view.
        APICallers.shared.getCurrentUserProfile(completionHandler: {
            (response) in
            
            switch response{
            case .success(let profile):
                print(profile)
                break
            
            case .failure(let err):
                print(err.reason)
            }
        })
    }


}

