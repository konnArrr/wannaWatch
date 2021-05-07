//
//  SearchListView.swift
//  wannWatch
//
//  Created by Student on 05.05.21.
//

import SwiftUI


enum SearchCategory: String, Equatable, CaseIterable {
    case movieSearch = "Search Movies"
    case tvShowSearch = "Search Tv Shows"
    
    // var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}


struct SearchListView: View {
    @StateObject private var viewModel = SearchListViewModel()
    @State private var searchString: String = ""
    @State private var showCancelButton: Bool = false
    @State private var searchCategory: SearchCategory = .movieSearch

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("search", text: $searchString, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        })
                        .foregroundColor(.primary)
                        .disableAutocorrection(true)
                        Button(action: {
                            self.searchString = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchString == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.searchString = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton)
                .onChange(of: searchString) {newValue in
                    postSearchMsgToRepo()
                }
                Picker("filterSetting", selection: $searchCategory) {
                    ForEach(SearchCategory.allCases, id: \.self) {
                        Text($0.rawValue).tag($0)
                        
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: searchCategory) { newValue in
                    print(searchCategory.rawValue)
                    searchString = ""
                }
                
                if !viewModel.searchedMoviesVm.isEmpty {
                    List {
                        ForEach(viewModel.searchedMoviesVm) {movie in
                            ZStack {
                                
                                Color.init(.sRGB, red: 0.6, green: 0.9, blue: 1.0, opacity: 0.5)
                                NavigationLink(destination: DetailMovieView(movie: movie, showAddButton: true)) {
                                    HStack {
                                        Spacer()
                                        Text(movie.title)
                                            .multilineTextAlignment(.center)
                                        Spacer()
                                    }
                                }
                                
                                .padding()
                                .border(Color.black, width: 2)
                                
                            }
                        }
                    }
                    .navigationTitle("Search")
                    .resignKeyboardOnDragGesture()
                } else {
                    Spacer()
                    Text("Please enter\nnew search text")
                        .font(Font.system(.title))
                        .multilineTextAlignment(.center)
                    Spacer()
                        .navigationTitle("Search")
                        .resignKeyboardOnDragGesture()
                }
            }
        }
    }
    private func postSearchMsgToRepo() {
        // sender für api call in repository
        switch searchCategory {
        case .movieSearch:
            NotificationCenter.default.post(name: .searchMovieQueryMsg, object: searchString)
            print("msg movie")
        case .tvShowSearch:
            NotificationCenter.default.post(name: .searchTvShowQueryMsg, object: searchString)
            print("msg tv shows")
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView()
    }
}


extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
