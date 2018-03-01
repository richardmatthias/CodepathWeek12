//
//  Movie.swift
//  Flix
//
//  Created by Langtian Qin on 2/28/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import Foundation

class Movie{
    
    var title: String
    var overview: String
    var posterUrl: URL?
    var bgUrl: URL?
    var date: String
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview=dictionary["overview"]as? String ?? "No overview"
        date=dictionary["release_date"]as? String ?? "No date"
        let posterPathString=dictionary["poster_path"]as!String
        let baseURLString="https://image.tmdb.org/t/p/w500"
        posterUrl=URL(string:baseURLString+posterPathString)!
        let bgPathString=dictionary["backdrop_path"]as!String
        bgUrl=URL(string:baseURLString+bgPathString)!
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
