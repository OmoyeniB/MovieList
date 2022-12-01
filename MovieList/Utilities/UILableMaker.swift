//
//  UILableMaker.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 30/11/2022.
//

import UIKit

public class UILabelMaker {
    
    public static func label(
        text: String? = nil,
        textColor: UIColor? = .black,
        lines: Int = 0,
        alignment: NSTextAlignment = .left) -> UILabel {
            let label = UILabel()
            label.text = text
            label.textColor = textColor
            label.numberOfLines = lines
            label.textAlignment = alignment
            
            return label
        }
}
