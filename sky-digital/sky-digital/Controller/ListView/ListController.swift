//
//  ListController.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 01/02/21.
//

import UIKit

public class ListController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var movieCollection: UICollectionView!
    @IBOutlet weak var subtitleLabel: UILabel!
    private var presenter: ListPresenter!
    
    private let cellIdentifier : String = "ListCollectionViewCell"
    
    private var actualIndex: Int?
    private var actualPoster: UIImage?

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = ListPresenter()
        
        self.movieCollection.delegate = self
        self.movieCollection.dataSource = self
        
        let nib = UINib.init(nibName: self.cellIdentifier, bundle: nil)
        self.movieCollection.register(nib, forCellWithReuseIdentifier: self.cellIdentifier)
        
        self.subtitleLabel.text = "Carregando uma seleção de filmes imperdíveis. Aguarde uns instantes..."
        
        self.presenter.getData(callBack: self.getData(_:_:))
    }
    
    private func getData(_ status: Bool, _ message: String) {
         if status {
            DispatchQueue.main.async {
                if self.presenter.getListCount() == 1 {
                    self.subtitleLabel.text = "Uma seleção de filmes imperdíveis:"
                }
                self.movieCollection.reloadData()
            }
        } else {
            DispatchQueue.main.async {
                if self.presenter.getListCount() == 0 {
                    self.subtitleLabel.text = "Ocorreu um erro, tente novamente mais tarde."
                }
            }
        }
    }

    // MARK: - Table view data source

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.getListCount()
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.movieCollection.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! ListCollectionViewCell

        cell.name = self.presenter.getMovieTitle(at: indexPath.row)
        cell.image = nil
        if let imageURL = self.presenter.getPosterURL(at: indexPath.row) {
            self.presenter.getImage(from: imageURL) {
                (data, status, message) in
                if status {
                    if let imageData = data {
                        cell.image = UIImage(data: imageData)
                    }
                } else {
                    print(message)
                }
            }
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.actualIndex = indexPath.row
        if let imageURL = self.presenter.getPosterURL(at: indexPath.row) {
            self.presenter.getImage(from: imageURL) {
                (data, status, message) in
                if status {
                    if let imageData = data {
                        self.actualPoster = UIImage(data: imageData)
                    }
                } else {
                    print(message)
                }
            }
        }
        
        performSegue(withIdentifier: "toDetailsSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsSegue" {
            let detailsController = segue.destination as! DetailsController
            detailsController.setPresenter(presenter: DetailsPresenter(movie: self.presenter.getMovie(at: self.actualIndex ?? -1)))
//            detailsController.presenter =  MoviePresenter(url: apiURL + "movie/" + (self.actualMovie?.id?.description ?? ""))
            if let poster = self.actualPoster {
                detailsController.poster = poster
            } else {
                if let imageURL = self.presenter.getPosterURL(at: self.actualIndex ?? -1) {
                    self.presenter.getImage(from: imageURL) {
                        (data, status, message) in
                        if status {
                            if let imageData = data {
                                detailsController.poster = UIImage(data: imageData)
                            }
                        } else {
                            print(message)
                        }
                    }
                }
            }
        }
    }
}
