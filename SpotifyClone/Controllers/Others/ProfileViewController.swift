//
//  ProfileViewController.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 04/06/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        return tableView
    }()
    
    var userProfile : UserProfile?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        
        getProfileData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    
    private func getProfileData(){
        APICallers.shared.getCurrentUserProfile(completionHandler: { [weak self]
            (response) in
            
            DispatchQueue.main.async {
                switch response{
                case .success(let profile):
                    self?.updateUI(with: profile)
                    break
                    
                case .failure(let err):
                    self?.failedToGetData(with: "profile")
                    print(err.reason)
                }
                
            }
            
            //
        })
    }
    
    private func updateUI(with model: UserProfile){
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    
}

extension ProfileViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "fas"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    

    
    
    
}
