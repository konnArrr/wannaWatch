//
//  Repository.swift
//  wannWatch
//
//  Created by Student on 05.05.21.
//

import Foundation
import Combine

extension Notification.Name {
    static let searchQueryMsg = Notification.Name("searchQueryMsg")
}



class Repository {
    
    
    @Published var movies = [Movie]()
    let dataLoader = DataLoader()
    private var cancellables: Set<AnyCancellable> = []
    init() {
        // empfänger
        NotificationCenter.Publisher(center: .default, name: .searchQueryMsg)
            .sink { notification in
                //                print("With Object notification: \(notification)")
                let object = notification.object // object ist vom Type Any ! da kann alles rein ...
                //                print("object: \(object)")
                // das gesendete object MUSS gecasted werden, um es zu verwenden!
                guard let searchQuery = object as? String else { return }
                self.searchForMoviesBy( searchQuery )
                //                print("user: \(user.name)")
            }.store(in: &cancellables)
    }
    
    private func searchForMoviesBy( _ query: String) {
        if query.isEmpty {
            movies.removeAll()
        }
        dataLoader.searchMovie(query: query)
        { [weak self] movies in
            self?.movies = movies
            // print("MOVIES: \(movies)")
        }
        
    }
}
