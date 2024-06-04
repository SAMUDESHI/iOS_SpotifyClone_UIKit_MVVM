//
//  WelcomeViewController.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 04/06/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        title = "Spotify"
        view.backgroundColor = .systemGreen
        // Do any additional setup after loading the view.
    }
    

    

}
