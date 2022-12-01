//
//  ControllerSceneDIContainer.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 30/11/2022.
//

import UIKit

final class ControllerSceneDIContainer {
    
    static let sharedInstance = ControllerSceneDIContainer()
    static var movieList: MovieList?
    
    func makeNetworkRepoInjectable() -> IMovieListNetworkResult {
        let networkService = AppDIContainer.makeNetworkService()
        return MovieListResult(dataSource: networkService)
    }
   
    func makeMovieListControllerInjectable() -> MovieListViewController {
        let vc = MovieListViewController()
        let networkRepo = makeNetworkRepoInjectable()
        vc.viewModel = MovieListViewModel(networkResult: networkRepo)
        return vc
    }
    
    func makeUserDetailsViewController(navigationController: UINavigationController) {
        let vc = DetailsViewController()
        var viewModelRepo = AppDIContainer.makeDetailsViewModel()
        viewModelRepo.movieListItem = ControllerSceneDIContainer.movieList
        vc.viewModel = viewModelRepo
        navigationController.pushViewController(vc, animated: true)
    }
    
}
