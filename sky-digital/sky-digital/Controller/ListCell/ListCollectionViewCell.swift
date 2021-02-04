//
//  ListCollectionViewCell.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 03/02/21.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    public var image: UIImage? = nil {
        didSet {
            self.imageView.image = self.image
        }
    }
    public var name: String? = nil {
        didSet {
            self.nameLabel.text = self.name
        }
    }
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }

}
