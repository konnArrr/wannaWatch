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
    private let searchTvShowUrlExtension = "/search/tv"
    private let searchMovieUrlExtension = "/search/movie"
    private let jsonDecoder = Utils.jsonDecoder
    private let urlSession = URLSession.shared
    
    
    
    
    
    
    func searchMovie(query: String, searchParams: [String : String]? = nil, completion: @escaping ([Watchable]) -> Void ) {
        guard let url: URL = URL(string: "\(baseApiUrl)/search/movie") else { return }
        search(url: url, query: query, searchParams: searchParams, completionFinal: completion) { (data, complition) in
            self.encodeJsonMovie(data, completion: complition)
        }
    }
    
    
    func searchTvShow(query: String, searchParams: [String : String]? = nil, completion: @escaping ([Watchable]) -> Void ) {
        guard let url: URL = URL(string: "\(baseApiUrl)\(searchTvShowUrlExtension)") else { return }
        search(url: url, query: query, searchParams: searchParams, completionFinal: completion) { (data, complition) in
            self.encodeJsonTVShow(data, completion: complition)
        }
    }

    
    func search(url: URL, query: String, searchParams: [String : String]? = nil, completionFinal: @escaping ([Watchable]) -> Void ,  encoding: @escaping (_ data: Data, _ completion: @escaping ([Watchable]) -> Void) -> Void) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let searchParams = searchParams {
            queryItems.append(contentsOf: searchParams.map {URLQueryItem(name: $0.key, value: $0.value)})
        }
        queryItems.append(URLQueryItem(name: "query", value: query))
        urlComponents.queryItems = queryItems
        guard  let finalURL = urlComponents.url else { return  }
        print("finalURL: \(finalURL)")
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
            encoding(data, completionFinal)
            // self.encodeJsonMovie(data, completion: completion)
            
        }
        task.resume()
    }
    

    
    fileprivate func encodeJsonMovie(_ data: Data, completion: @escaping ([Watchable]) -> Void) {
        do {
            let jsonDataInitial = try self.jsonDecoder.decode(InitialMovieDTO.self, from: data)
            let resultMovieDTO = jsonDataInitial.results
            DispatchQueue.main.async {
                let searchedMovies = resultMovieDTO.map{ $0.mapToWatchable() }
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
    
    
    fileprivate func encodeJsonTVShow(_ data: Data, completion: @escaping ([Watchable]) -> Void) {
        do {
            let jsonDataInitial = try self.jsonDecoder.decode(InitialTvShowDTO.self, from: data)
            let resultMovieDTO = jsonDataInitial.results
            DispatchQueue.main.async {
                let searchedMovies = resultMovieDTO.map{ $0.mapToWatchable() }
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
    
    
    
}

