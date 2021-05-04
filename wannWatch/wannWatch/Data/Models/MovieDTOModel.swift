//
//  UserDTOModel.swift
//  wannWatch
//
//  Created by Student on 04.05.21.
//

import Foundation

struct MovieDTO {
    let id: Int
    let title: String
    let originalLanguage: String
    
    func mapToMovie() -> Movie {
        return Movie(id: self.id, title: self.title, originalLanguage: self.originalLanguage)
    }
}
