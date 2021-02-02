//
//  ListController.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 01/02/21.
//

import UIKit

class ListController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var movieCollection: UICollectionView!
    @IBOutlet weak var subtitleLabel: UILabel!
//    var presenter: ListPresenter!

    var list: [Any] = []
    
    let cellIdentifier : String = "ListCollectionCell"
    
    var actualMovie: Any?
    var actualPoster: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.presenter = ListPresenter()
        
        self.movieCollection.delegate = self
        self.movieCollection.dataSource = self
        
        self.movieCollection.register(ListCollectionCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        
//        self.presenter.getData(callBack: self.getData(_:_:_:))
    }
    
//    func getData(_ list: [Movie]?, _ status: Bool, _ message: String) {
//         if status {
//            self.list = list ?? []
//            self.movieCollection.reloadData()
//        } else {
//            print(message, self.description)
//        }
//    }

    // MARK: - Table view data source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.movieCollection.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! ListCollectionCell

        let movie = self.list[indexPath.row]
//        cell.name = movie.title
        cell.image = nil
//        if let imageURL = movie.poster_path {
//            self.presenter.getImage(from: apiLowImageURL + imageURL) {
//                (data, status, message) in
//                if status {
//                    if let imageData = data {
//                        cell.img.image = UIImage(data: imageData)
//                    }
//                } else {
//                    print(message)
//                }
//            }
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.movieCollection.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! ListCollectionCell
        
        self.actualPoster = cell.image
        self.actualMovie = self.list[indexPath.row]
        
        performSegue(withIdentifier: "toDetailsSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsSegue" {
            let detailsController = segue.destination as! DetailsController
            detailsController.movie = self.actualMovie
//            detailsController.presenter =  MoviePresenter(url: apiURL + "movie/" + (self.actualMovie?.id?.description ?? ""))
            detailsController.poster = self.actualPoster
        }
    }
}
