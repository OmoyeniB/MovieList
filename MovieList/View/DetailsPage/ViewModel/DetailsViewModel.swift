//
//  DetailsViewModel.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 01/12/2022.
//

import UIKit
import LinkPresentation

protocol DetailsViewModelProtocol {
    var movieListItem: MovieList? {get set}
}

class DetailsViewModel: DetailsViewModelProtocol {
    var movieListItem: MovieList?
    
}
