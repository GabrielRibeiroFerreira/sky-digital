//
//  DetailsPresenter.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 09/02/21.
//

import Foundation


public class DetailsPresenter {
    private var movie: Movie?
    
    init(movie: Movie?) {
        self.movie = movie
    }
    
    public func getTitle() -> String {
        return movie?.title?.title ?? "NOT FOUND"
    }
    
    public func getDate() -> String {
        return movie?.releaseDate ?? ""
    }
    
    public func getDescription() -> String {
        return movie?.plotSummary?.text ?? ""
    }
}
