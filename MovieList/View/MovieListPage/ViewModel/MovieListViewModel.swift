//
//  MovieListViewModel.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 30/11/2022.
//

import Foundation

protocol IMovieListViewModel {
    func fetchFromJsonPath()
    var movieList: MovieModel? {get set}
    var showMovieList: ((Bool) -> Void)? { get set }
    var showError: ((Error) -> Void)? { get set }
}

class MovieListViewModel: IMovieListViewModel{
    var movieList: MovieModel?
    var showMovieList: ((Bool) -> Void)?
    var showError: ((Error) -> Void)?
    
    fileprivate var networkResult: IMovieListNetworkResult
    
    init(networkResult: IMovieListNetworkResult) {
        self.networkResult = networkResult
    }
    
    func fetchFromJsonPath() {
        networkResult.fetchMovieList(completion: { results in
            switch results {
            case .success(let data):
                self.movieList = data
                self.showMovieList?(true)
            case .failure(let error):
                self.showError?(error)
            }
        })
    }
    
}
