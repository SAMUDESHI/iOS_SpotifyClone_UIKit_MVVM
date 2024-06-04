//
//  TabBarViewController.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 04/06/24.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    let vc1 = HomeViewController()
    let vc2 = SearchViewController()
    let vc3 = LibraryViewController()
    var navarray = [UINavigationController]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupTabBarItems(vc: vc1, title: "Browse", icon: "house")
        setupTabBarItems(vc: vc2, title: "Search", icon: "magnifyingglass")
        setupTabBarItems(vc: vc3, title: "Library", icon: "music.note.list")
        // Do any additional setup after loading the view.
        setViewControllers(navarray, animated: false)
    }
    
   

    func setupTabBarItems(vc : UIViewController , title : String, icon : String){
        vc.navigationItem.largeTitleDisplayMode = .always
        vc.title = title
        vc.view.backgroundColor = .systemBackground
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.prefersLargeTitles = true
        nav.navigationBar.tintColor = .label
        nav.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: icon), tag: 1)
        navarray.append(nav)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
