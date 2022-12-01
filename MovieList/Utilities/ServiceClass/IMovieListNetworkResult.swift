//
//  MovieListResultRepository.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 30/11/2022.
//

import Foundation

protocol IMovieListNetworkResult{
    func fetchMovieList(completion: @escaping (Result<MovieModel, Error>) -> Void)
    var fileName: String {get set}
}

class MovieListResult: IMovieListNetworkResult{
    
    var fileName: String = "MovieList"
    fileprivate var dataSource: INetworkManagerRepository
    
    init(dataSource: INetworkManagerRepository) {
        self.dataSource = dataSource
    }
    
    func fetchMovieList(completion: @escaping (Result<MovieModel, Error>) -> Void) {
        dataSource.loadFromJson(fileName, expecting: MovieModel.self, completionHandler: { results in
            switch results {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    
    
}
