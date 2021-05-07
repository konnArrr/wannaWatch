//
//  Repository.swift
//  wannWatch
//
//  Created by Student on 05.05.21.
//

import Foundation
import Combine





extension Notification.Name {
    static let searchMovieQueryMsg = Notification.Name("searchMovieQueryMsg")
    static let searchTvShowQueryMsg = Notification.Name("searchTvShowQueryMsg")
}



class Repository {
    
    
    @Published var watchables = [Watchable]()
    let dataLoader = DataLoader()
    private let queryParamter = ["include_adult" : "true" ]
    private var cancellables: Set<AnyCancellable> = []
    init() {
        // empfänger, sender in earch list view
        NotificationCenter.Publisher(center: .default, name: .searchMovieQueryMsg)
            .sink { notification in
                let object = notification.object // object ist vom Type Any ! da kann alles rein ...
                guard let searchQuery = object as? String else { return }
                self.searchForMoviesBy( searchQuery )
            }.store(in: &cancellables)
        NotificationCenter.Publisher(center: .default, name: .searchTvShowQueryMsg)
            .sink { notification in
                let object = notification.object // object ist vom Type Any ! da kann alles rein ...
                guard let searchQuery = object as? String else { return }
                self.searchForTvShowsBy( searchQuery )
            }.store(in: &cancellables)
    }
    
    
    private func searchForTvShowsBy( _ query: String) {
        if query.isEmpty {
            watchables.removeAll()
        }
        dataLoader.searchTvShow(query: query, searchParams: queryParamter)
        { [weak self] tvShows in
            self?.watchables = tvShows
            // print("MOVIES: \(tvShows)")
        }
    }
    
    
    private func searchForMoviesBy( _ query: String) {
        if query.isEmpty {
            watchables.removeAll()
        }
        dataLoader.searchMovie(query: query, searchParams: queryParamter)
        { [weak self] movies in
            self?.watchables = movies
            // print("MOVIES: \(movies)")
        }
    }
}
