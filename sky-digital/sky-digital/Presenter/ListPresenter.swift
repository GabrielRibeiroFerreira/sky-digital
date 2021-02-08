//
//  ListPresenter.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 01/02/21.
//

import Foundation

public class ListPresenter {
    typealias DataListCallBack = (_ dataList: [Movie]?, _ status: Bool, _ message: String) -> Void
    typealias ImageCallBack = (_ imageData: Data?, _ status: Bool, _ message: String) -> Void
    
    var service : ServiceProtocol!
    
    var actualPage : Int = 1
    var pages : Int = 0
    var total : Int = 0
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    init() {
        self.service = Service()
    }
    
    //MARK: -LIST
    
    //get list from cache or service
    func getData(callBack: @escaping DataListCallBack) {
        //generate a key to try to get from cache
        let key = String(self.actualPage)
        
        //try to get the list from cache or try to get from service
        let list: [String] = self.getListFromCache(key: key) ?? []
        if list == [] {
            self.getListFromService(callBack: callBack) { (list) in
                self.getMovies(list: list, callBack: callBack)
            }
        } else {
            self.getMovies(list: list, callBack: callBack)
        }
    }
    
    //get data from cache with a key and a type
    func getListFromCache(key: String) -> [String]? {
        //get from cache
        guard let wrapper = Cache.getListCache(withKey: key) else { return nil }
        guard let list = wrapper.results else { return nil }
        
        //return list
        return list
    }
    
    //get data from service with a url and a type
    func getListFromService(callBack: @escaping DataListCallBack, listReturn: @escaping (([String]) -> Void)){
        do {
            let parameters = ["x-rapidapi-key": apiKey,
                              "x-rapidapi-host": apiHost
                            ] as [String : String]
            try service.getData(from: apiURL + "title/get-most-popular-movies",
                                parameters: parameters,
                                callBack: { [weak self] (serviceData, status, message) in
                if status {
                    guard let data = serviceData else { return }
                    do {
                        guard let self = self else {return}
                        let list = try JSONDecoder().decode([String].self, from: data)
                        let wrapper = Wrapper()
                        wrapper.results = list
                        
                        let key = String(self.actualPage)
                        Cache.setListCache(wrapper, withKey: key)

                         listReturn(list)
                    } catch {
                        print(error)
                        callBack(nil, false, "")
                    }
                } else {
                    print(message, self.debugDescription)
                    callBack(nil, false, message)
                }
            })
        }catch ConnectErrors.receivedFailure{
            callBack(nil, false, "Lack of internet connection")
        }catch{
            callBack(nil, false, error.localizedDescription)
        }
    }
    
    //MARK: -MOVIE
    
    func getMovies(list: [String], callBack: @escaping DataListCallBack) {
        var passed: Int = 0
        var movies: [Movie] = [] {
            didSet {
                if (movies.count == passed) {// % 20 == 0) {
                    callBack(movies, true, "")
                }
            }
        }
        var i: Double = 0
        for title in list {
            passed += 1
            var key = title.substring(from: 7)
            key = key.substring(to: key.count - 1)
            if let movie = self.getMovieFromCache(key: title) {
                movies.append(movie)
            } else {
                if i > 0 { break }
                DispatchQueue.main.asyncAfter(deadline: .now() + (i * 0.4)) {
                    self.getMovieFromService(key: key) { (movie) in
                        movies.append(movie)
                    }
                }
                i += 1
            }
        }
    }
    
    func getMovieFromCache(key: String) -> Movie? {
        //get from cache
        guard let movie = Cache.getMovieCache(withKey: key) else { return nil }
        
        //return movie
        return movie
    }
    
    func getMovieFromService(key: String, movieReturn: @escaping ((Movie) -> Void)) {
        do {
            let parameters = ["x-rapidapi-key": apiKey,
                              "x-rapidapi-host": apiHost
                            ] as [String : String]
 
            try service.getData(from: apiURL + "title/get-overview-details?tconst=" + key,
                                parameters: parameters,
                                callBack: { [weak self] (serviceData, status, message) in
                if status {
                    guard let data = serviceData else { return }
                    do {
                        let movie = try JSONDecoder().decode(Movie.self, from: data)
                        if let key = movie.id {
                            Cache.setMovieCache(movie, withKey: key)
                        }
                        
                        movieReturn(movie)
                    } catch {
                        print(error)
                    }
                } else {
                    print(message, self.debugDescription)
//                    callBack(nil, false, message)
                }
            })
        }catch ConnectErrors.receivedFailure{
//            callBack(nil, false, "Lack of internet connection")
        }catch{
//            callBack(nil, false, error.localizedDescription)
        }
    }
    
    //MARK: -IMAGE
    
    func getImage(from url: String, callBack: @escaping ImageCallBack) {
        //try to get the image from cache or try to get from service
        if let imageData = self.getImageFromCache(key: url) {
            callBack(imageData, true, "")
        } else {
            self.getImageFromService(from: url, callBack: callBack)
        }
    }
    
    func getImageFromCache(key: String) -> Data? {
        //data of image
        var data: Data? = nil
        
        //get image data from cache
        guard let nsData = Cache.getImageCache(withKey: key) else { return nil }
        data = nsData as Data
        
        return data
    }
    
    func getImageFromService(from url: String, callBack: @escaping ImageCallBack) {
        do {
            try self.service.getData(from: url, parameters: nil) { (data, status, message) in
                if status {
                    if let imageData = data {
                        Cache.setImageCache(imageData as NSData, withKey: url)
                    }
                }
                callBack(data, status, message)
            }
        } catch ConnectErrors.receivedFailure{
            callBack(nil, false, "Lack of internet connection")
        }catch{
            callBack(nil, false, error.localizedDescription)
        }
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
