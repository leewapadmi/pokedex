//
//  ImagePreloader.swift
//  pokedex
//
//  Created by Lee Wilson on 24/06/2024.
//

import Combine
import Kingfisher

//sourcery: AutoMockable
protocol ImagePreloader {
    func preloadImages(rawUrls: [String], withTimeout timeoutSeconds: Double) -> AnyPublisher<Void, Error>
    func preloadImages(rawUrls: [String]) -> AnyPublisher<Void, Error>
}

final class ImagePreloaderImpl : ImagePreloader {
    
    /**
     Preload images with specified timeout.
     */
    func preloadImages(
        rawUrls: [String],
        withTimeout timeoutSeconds: Double
    ) -> AnyPublisher<Void, Error> {
        let urls = rawUrls.compactMap { URL(string: $0) }
        if urls.isEmpty {
            print("No valid URLs passed to image prefetcher! Ignoring.")
            return Just(())
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return Future<Void, Error>() { promise in
            let downloader = ImageDownloader(name: "prefetchDownloader")
            downloader.downloadTimeout = timeoutSeconds
            ImagePrefetcher(
                urls: urls,
                options: KingfisherOptionsInfo([.downloader(downloader)])
            ) { skipped, failed, completed in
                print("Preloaded \(completed.count) images (\(failed.count) failed, \(skipped.count) skipped).")
                promise(.success(()))
            }.start()
        }
        .eraseToAnyPublisher()
    }
    
    /**
     Preload images with default timeout of 5 seconds.
     */
    func preloadImages(rawUrls: [String]) -> AnyPublisher<Void, Error> {
        return preloadImages(rawUrls: rawUrls, withTimeout: 5.0)
    }
}
