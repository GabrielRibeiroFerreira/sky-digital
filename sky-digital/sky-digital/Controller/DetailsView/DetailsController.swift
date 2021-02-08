//
//  DetailsController.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 01/02/21.
//


import UIKit

public class DetailsController: UIViewController {
    var movie: Movie!
    var poster: UIImage! {
        didSet {
            if let view = self.posterView {
                view.image  = self.poster
            }
        }
    }
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setView()
    }
    
    func setView() {
        self.title = self.movie.title?.title
        self.titleLabel.text = self.movie.title?.title
        self.dateLabel.text = "lançamento: " + (self.movie.releaseDate ?? "")
        self.descriptionLabel.text = self.movie.plotSummary?.text
        self.posterView.image = self.poster
    }
}
