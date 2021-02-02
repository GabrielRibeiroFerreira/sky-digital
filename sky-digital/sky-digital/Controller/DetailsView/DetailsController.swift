//
//  DetailsController.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 01/02/21.
//


import UIKit

public class DetailsController: UIViewController {
//    var presenter: MoviePresenter!
    var movie: Any!
    var poster: UIImage! {
        didSet {
            self.posterView.image = self.poster
        }
    }
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
//    var people: [People] = []
//    var credit: CreditsWrapper?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setView()
//        self.presenter.getData(callBack: self.getMovie(_:_:_:))
//        if let id = self.movie.id {
//            self.presenter.peopleUrl = "movie/" + id.description + "/credits"
//        }
//        self.presenter.getPeopleData(callBack: self.getCredits(_:_:_:))
    }
    
    func setView() {
//        self.title = self.movie.original_title
//        self.dateLabel.text = "lançamento: " + (self.movie.release_date ?? "")
//        self.runtimeLabel.text = (self.movie.runtime?.description ?? "") + " min"
//        self.overviewLabel.text = self.movie.overview
//        self.posterImage.image = self.poster
//        self.statusLabel.text = "status: " + (self.movie?.status ?? "")
//
//        //getting the poster in high quality
//        if let imageURL = movie.poster_path {
//            self.presenter.getImage(from: apiHighImageURL + imageURL) {
//                (data, status, message) in
//                if status {
//                    if let imageData = data {
//                        self.posterImage.image = UIImage(data: imageData)
//                    }
//                } else {
//                    print(message)
//                }
//            }
//        }
    }
    
//    func getMovie(_ movie: Movie?, _ status: Bool, _ message: String) {
//        if status {
//            self.movie = movie
//            self.setView()
//        } else {
//            print(message, self.description)
//        }
//    }
//
//    func getCredits(_ credit: CreditsWrapper?, _ status: Bool, _ message: String) {
//        if status {
//            self.credit = credit
//            self.people = credit!.cast!
//            self.peopleTableView.reloadData()
//        } else {
//            print(message, self.description)
//        }
//    }
}
