//
//  Cache.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 01/02/21.
//

import Foundation

struct Cache {
    static var defaults = UserDefaults.standard {
        didSet {
            Cache.imageCache.removeAllObjects()
            Cache.listCache.removeAllObjects()
            Cache.movieCache.removeAllObjects()
        }
    }
    static private let imageCache = NSCache<NSString, NSData>()
    static private let listCache = NSCache<NSString, Wrapper>()
    static private let movieCache = NSCache<NSString, Movie>()
    
    static func setMovieCache(_ movie: Movie, withKey key: String) {
        Cache.movieCache.setObject(movie, forKey: NSString(string: key))
        
        do {
            let encoded = try JSONEncoder().encode(movie)
            Cache.defaults.set(encoded, forKey: key)
        }
        catch {
            print(error)
        }
    }
    
    static func setListCache(_ wrapper: Wrapper, withKey key: String) {
        Cache.listCache.setObject(wrapper, forKey: NSString(string: key))
        
        do {
            let encoded = try JSONEncoder().encode(wrapper)
            Cache.defaults.set(encoded, forKey: key)
        }
        catch {
            print(error)
        }
    }
    
    static func setImageCache(_ image: NSData, withKey key: String) {
        Cache.imageCache.setObject(image, forKey: NSString(string: key))
        
        Cache.defaults.set(image, forKey: key)
    }
    
    static func getMovieCache(withKey key:  String) -> Movie? {
        var movie: Movie?
        if let movieCache = Cache.movieCache.object(forKey: key as NSString) {
            movie = movieCache
        } else {
            do {
                if let data = Cache.defaults.data(forKey: key) {
                  movie = try JSONDecoder().decode(Movie.self, from:data)
               }
            }
            catch {
                print(error)
            }
            
            if let m = movie {
                Cache.movieCache.setObject(m, forKey: NSString(string: key))
            }
        }
        
        return movie
    }
    
    static func getListCache(withKey key:  String) -> Wrapper? {
        var wrapper: Wrapper?
        if let wrapperCache = Cache.listCache.object(forKey: key as NSString) {
            wrapper = wrapperCache
        } else {
            do {
                if let data =  Cache.defaults.data(forKey: key) {
                  wrapper = try JSONDecoder().decode(Wrapper.self, from:data)
               }
            }
            catch {
                print(error)
            }
            
            if let w = wrapper {
                Cache.listCache.setObject(w, forKey: NSString(string: key))
            }
        }
        
        return wrapper
    }
    
    static func getImageCache(withKey key:  String) -> NSData? {
        var image: NSData?
        if let imageCache = Cache.imageCache.object(forKey: key as NSString) {
            image = imageCache
        } else {
            image = defaults.object(forKey: key) as? NSData
            
            if let i = image {
                Cache.imageCache.setObject(i, forKey: NSString(string: key))
            }
        }
        
        return image
    }
}
