//
//  ViewController.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 03/06/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return Self.createSectionLayout(index: sectionIndex)
        })

    override func viewDidLoad() {
        super.viewDidLoad()
        getFeaturedPlaylist()
        //title = "Home"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
        renderCollectionView()
        
       
    }
    
    func renderCollectionView(){
        
        
    }
    
    private static func createSectionLayout(index: Int) -> NSCollectionLayoutSection{
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), 
                                               heightDimension: .absolute(120)),
            subitems: <#T##[NSCollectionLayoutItem]#>,
            count: 1)
        
        let section = NSCollectionLayoutSection(group: <#T##NSCollectionLayoutGroup#>)
    }
    
    private func getFeaturedPlaylist(){
        
        APICallers.shared.getRecommendationsGenres(completionHandler: {
            results in
            
            switch results{
            case.success(let data):
                print(data)
                let genres = data.genres
                var seed = Set<String>()
                while seed.count < 5 {
                    if let random = genres.randomElement(){
                        seed.insert(random)
                    }
                }
                var genresString = seed.joined(separator: ",")
                APICallers.shared.getRecommendations(genres: genresString, completionHandler: {
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

