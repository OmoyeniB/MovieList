//
//  UIView+Extensions.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 30/11/2022.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
     }
    
    func separateWordsByComponenet(link: String) -> String {
        let firstWord = link.components(separatedBy: "=").last ?? ""
        return firstWord
    }
}
