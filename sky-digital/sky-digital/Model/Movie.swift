//
//  Movie.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 01/02/21.
//

import Foundation

public class Movie: Codable {
    public var id: String?
    public var plotSummary: PlotSummary?
    public var releaseDate: String?
    public var title: Title?
    
    public struct Title: Codable {
        var id: String?
        var image: Image?
        var title: String?
        var titleType: String?
        var year: Int?
    }
    
    public struct Image: Codable {
        var height: Int?
        var id: String?
        var url: String?
        var width: Int?
    }
    
    public struct PlotSummary: Codable {
        var author: String?
        var id: String?
        var text: String?
    }
}
