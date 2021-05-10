//
//  ContentView.swift
//  wannWatch
//
//  Created by Student on 04.05.21.
//

import SwiftUI

struct ContentView: View {
    var searchString: String = "Doom"
    var body: some View {
        TabView {
            SearchListView()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle")
                    Text("Search")
                }
            FavouriteMoviesView()
                .tabItem {
                    Image(systemName: "hand.thumbsup")
                    Text("Favourites")                        
                }
        }
    }
    private func postSearchMsgToRepo() {
        print("button pressed")
        NotificationCenter.default.post(name: .movieSearchQueryMessage, object: searchString)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
