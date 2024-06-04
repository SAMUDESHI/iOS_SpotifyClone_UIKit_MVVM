//
//  WelcomeViewController.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 04/06/24.
//

import UIKit

class WelcomeViewController: UIViewController {

    private let signInButton : UIButton = {
        var button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 25
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(self.didTapSignIn), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(
            x: 20,
            y: view.height-50-view.safeAreaInsets.bottom,
            width: view.width-40,
            height: 50
        )
    }
    

    @objc func didTapSignIn(){
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] sucess in
            DispatchQueue.main.async {
                self?.handleSignIn(sucess: sucess)
            }
            
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(sucess: Bool){
        
        if sucess{
            let vc = TabBarViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated:  true)
        }else{
            let alert = UIAlertController(title: "Oops", message: "Something went wrong. Mind trying again.", preferredStyle:  .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
            present(alert,animated: true)
        }
    }

}
