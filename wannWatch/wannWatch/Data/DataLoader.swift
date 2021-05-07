//
//  DataLoader.swift
//  wannWatch
//
//  Created by Student on 04.05.21.
//

import SwiftUI
import Combine



class DataLoader {
    
    @AppStorage("data") private var dataForAppStorage: Data = Data()
    
    
    private let apiKey = "b72b15054c21b85d522621bebf6af664"
    private let baseApiUrl = "https://api.themoviedb.org/3"
    private let jsonDecoder = Utils.jsonDecoder
    private let urlSession = URLSession.shared
    
    func searchMovie(query: String, searchParams: [String : String]? = nil, completion: @escaping ([Movie]) -> Void) {
        guard let url: URL = URL(string: "\(baseApiUrl)/search/movie") else { return }
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let searchParams = searchParams {
            queryItems.append(contentsOf: searchParams.map {URLQueryItem(name: $0.key, value: $0.value)})
        }
        queryItems.append(URLQueryItem(name: "query", value: query))
        urlComponents.queryItems = queryItems
        guard  let finalURL = urlComponents.url else { return  }
//        print("finalURL: \(finalURL)")
        let task = urlSession.dataTask(with: finalURL) {  (data, response, error) in
//            [weak self]
//            guard let self = self else { return }
            guard error == nil else { return }
//            print("error: \(error)")
            guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else { return }
            let statusCode = httpResponse.statusCode
//            print("statusCode: \(statusCode)")
            guard (200..<299).contains(statusCode) else { return }
//            print("data: \(data)")
            guard let data = data else { return }
            do {
                let jsonDataInitial = try self.jsonDecoder.decode(Initial.self, from: data)
                let resultMovieDTO = jsonDataInitial.results
                DispatchQueue.main.async {
                    let searchedMovies = resultMovieDTO.map{ $0.mapToMovie() }
                    completion(searchedMovies)
                }
            } catch DecodingError.keyNotFound(let key, let context) {
                Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            } catch DecodingError.valueNotFound(let type, let context) {
                Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.typeMismatch(let type, let context) {
                Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.dataCorrupted(let context) {
                Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            } catch let error as NSError {
                NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            }
            
        }
        task.resume()
        }

    
    
//    func searchMovie(query: String, searchParams: [String : String]? = nil) -> [Movie] {
//        guard let url: URL = URL(string: "\(baseApiUrl)/search/movie") else { return nil }
//        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
//        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
//        if let searchParams = searchParams {
//            queryItems.append(contentsOf: searchParams.map {URLQueryItem(name: $0.key, value: $0.value)})
//        }
//
//        queryItems.append(URLQueryItem(name: "query", value: query))
//        urlComponents.queryItems = queryItems
//
//        guard  let finalURL = urlComponents.url else {
//            return
//        }
//        print("finalURL: \(finalURL)")
//        let task = urlSession.dataTask(with: finalURL) {  (data, response, error) in
////            [weak self]
////            guard let self = self else { return }
//            guard error == nil else { return }
////            print("error: \(error)")
//            guard let httpResponse: HTTPURLResponse = response as? HTTPURLResponse else { return }
//            let statusCode = httpResponse.statusCode
////            print("statusCode: \(statusCode)")
//            guard (200..<299).contains(statusCode) else { return }
////            print("data: \(data)")
//            guard let data = data else { return }
//            // let jsonDecoder = JSONDecoder()
//            // let jsonDecoder = Utils.jsonDecoder
//            do {
//                //let searchedMoviesDTOs = try self.jsonDecoder.decode([MovieDTO].self, from: data)
//                //print("jsonDecoder: \(jsonDecoder)")
//                let jsonDataInitial = try self.jsonDecoder.decode(Initial.self, from: data)
//                let resultMovieDTO = jsonDataInitial.results
//                DispatchQueue.main.async { [weak self] in
//                    self?.searchedMovies = resultMovieDTO.map{ $0.mapToMovie() }
////                    let test = resultMovieDTO.map{ $0.mapToMovie() }
////                    self?.searchedMovies = test
////                    print("test: \(test)")
////                    print("searchedMovies: \(self?.searchedMovies)")
//                }
//            } catch DecodingError.keyNotFound(let key, let context) {
//                Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
//            } catch DecodingError.valueNotFound(let type, let context) {
//                Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
//            } catch DecodingError.typeMismatch(let type, let context) {
//                Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
//            } catch DecodingError.dataCorrupted(let context) {
//                Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
//            } catch let error as NSError {
//                NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
//            }
//
//        }
//        task.resume()
//    }
    
    
    
    
}

