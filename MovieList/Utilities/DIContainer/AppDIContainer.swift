//
//  AppDIContainer.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 30/11/2022.
//

import Foundation

class AppDIContainer {
    
    static func makeNetworkService() -> INetworkManagerRepository {
        return NetworkManagerRepository()
    }
    
    static func makeDetailsViewModel() -> DetailsViewModelProtocol {
        return DetailsViewModel()
    }
    
    static func makeMovieViewSceneDIContainer() -> ControllerSceneDIContainer {
        return ControllerSceneDIContainer.sharedInstance
    }
}
