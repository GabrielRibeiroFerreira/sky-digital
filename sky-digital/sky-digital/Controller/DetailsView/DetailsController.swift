//
//  DetailsController.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 01/02/21.
//


import UIKit

public class DetailsController: UIViewController {
    private var presenter: DetailsPresenter = DetailsPresenter(movie: nil)
    var poster: UIImage? = nil {
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
    
    public func setPresenter(presenter: DetailsPresenter) {
        self.presenter = presenter
        
    }
    
    func setView() {
        self.title = self.presenter.getTitle()
        self.titleLabel.text = self.presenter.getTitle()
        self.dateLabel.text = "lançamento: " + self.presenter.getDate()
        self.descriptionLabel.text = self.presenter.getDescription()
        self.posterView.image = self.poster
    }
}
