//
//  Movie.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 01/02/21.
//

import Foundation

public class Movie: Codable {
    var id: String?
    var plotSummary: PlotSummary?
    var releaseDate: String?
    var title: Title?
    
    struct Title: Codable {
        var id: String?
        var image: Image?
        var title: String?
        var titleType: String?
        var year: Int?
    }
    
    struct Image: Codable {
        var height: Int?
        var id: String?
        var url: String?
        var width: Int?
    }
    
    struct PlotSummary: Codable {
        var author: String?
        var id: String?
        var text: String?
    }
}
