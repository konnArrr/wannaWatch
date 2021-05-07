//
//  SearchListViewModel.swift
//  wannWatch
//
//  Created by Student on 05.05.21.
//

import Foundation
import Combine

class SearchListViewModel: ObservableObject {
    @Published private(set) var searchedMoviesVm = [Movie]()
    private let repository = Repository()
    private var cancellbale: AnyCancellable?
    init() {
        cancellbale = repository.$movies.sink(receiveValue: { [weak self] searchedMovies in
            self?.searchedMoviesVm = searchedMovies
        })
    }
}
