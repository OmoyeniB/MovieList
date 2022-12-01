//
//  NetworkManagerRepository.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 30/11/2022.
//

import Foundation

protocol INetworkManagerRepository {
    func loadFromJson<T: Decodable>(_ filename: String, expecting: T.Type,
                                    completionHandler: @escaping (Result<T, Error>) -> Void)
}

final class NetworkManagerRepository: INetworkManagerRepository{
    
    public func loadFromJson<T: Decodable>(_ filename: String, expecting: T.Type,
                                           completionHandler: @escaping (Result<T, Error>) -> Void) {
        let data: Data
        
        guard let path = Bundle.main.path(forResource: filename, ofType: "json")
                
        else{
            completionHandler(.failure(NetworkingError.invalidUrl))
            Logger.printIfDebug(data: "\(filename) not found.", logType: .error)
            return
        }
        do {
            let file = URL(fileURLWithPath: path)
            data = try Data(contentsOf: file)
        } catch {
            Logger.printIfDebug(data: "Could not load \(filename): (error)", logType: .error)
            return
        }
        
        do{
            let result = try JSONDecoder().decode(expecting, from: data)
            completionHandler(.success(result))
        } catch {
            completionHandler(.failure(error))
            Logger.printIfDebug(data: "\(error.localizedDescription)", logType: .error)
        }
    }
}
