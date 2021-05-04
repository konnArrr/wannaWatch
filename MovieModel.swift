//
//  MovieModel.swift
//  wannWatch
//
//  Created by Student on 04.05.21.
//

import Foundation


struct Movie: Identifiable {
    
    let id: Int
    let title: String
    let originalLanguage: String
    
    internal init(id: Int, title: String, originalLanguage: String) {
        self.id = id
        self.title = title
        self.originalLanguage = originalLanguage
    }
    
}
