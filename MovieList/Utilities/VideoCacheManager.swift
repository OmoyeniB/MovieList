//
//  VideoCacheManager.swift
//  MovieList
//
//  Created by Sharon Omoyeni Babatunde on 01/12/2022.
//

import UIKit
import AVFoundation
import LinkPresentation

protocol VideoCacheProtocol {
    func didShowError(error: String)
}

final class VideoCacheManager {
    
    private var delegate: VideoCacheProtocol?
    private let storage = UserDefaults.standard
    
    func store(_ metadata: LPLinkMetadata) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: metadata, requiringSecureCoding: true)
            var metadatas = storage.dictionary(forKey: "Metadata") as? [String: Data] ?? [String: Data]()
            while metadatas.count > 10 {
                metadatas.removeValue(forKey: metadatas.randomElement()!.key)
            }
            metadatas[metadata.originalURL!.absoluteString] = data
            storage.set(metadatas, forKey: "Metadata")
        }
        catch {
            delegate?.didShowError(error: error.localizedDescription)
            Logger.printIfDebug(data: error.localizedDescription, logType: .error)
        }
    }
    
    func metadata(for url: URL) -> LPLinkMetadata? {
        guard let metadatas = storage.dictionary(forKey: "Metadata") as? [String: Data] else { return nil }
        guard let data = metadatas[url.absoluteString] else { return nil }
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: LPLinkMetadata.self, from: data)
        }
        catch {
            delegate?.didShowError(error: error.localizedDescription)
            Logger.printIfDebug(data: error.localizedDescription, logType: .error)
            return nil
        }
    }
}
