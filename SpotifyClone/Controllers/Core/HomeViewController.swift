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
        getFeaturedPlaylist()
        //title = "Home"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        
        
       
    }
    
    private func getFeaturedPlaylist(){
         APICallers.shared.getFeaturedPlaylist(completionHandler: {
             results in
             
             switch results{
             case.success(let data):
                 print(data)
                 break
             
             case.failure(let error):
                 print(error)
                 break
             }
             
         })
     }
    
   private func getNewReleases(){
        APICallers.shared.getNewReleases(completionHandler: {
            results in
            
            switch results{
            case.success(let data):
                print(data)
                break
            
            case.failure(let error):
                print(error)
                break
            }
            
        })
    }
    
    @objc func didTapSettings(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }


}

