//
//  Extension+UIViewController.swift
//  SpotifyClone
//
//  Created by Saavaj Studios on 08/06/24.
//

import Foundation
import UIKit

extension UIViewController{
    
    func failedToGetData(with pageName : String){
        let label = UILabel(frame: .zero)
        label.text = "Failed to load \(pageName)."
        label.sizeToFit()
        label.textColor = .secondaryLabel
        self.view.addSubview(label)
        label.center = view.center
    }
}
