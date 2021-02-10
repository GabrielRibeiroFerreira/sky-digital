//
//  ListCollectionViewCell.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 03/02/21.
//

import UIKit

public class ListCollectionViewCell: UICollectionViewCell {
    public var image: UIImage? = nil {
        didSet {
            DispatchQueue.main.async {
                self.imageView.image = self.image
            }
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

    public override func prepareForReuse() {
        super.prepareForReuse()
        isHidden = false
        isSelected = false
        isHighlighted = false
        self.image = nil
        self.name = nil
    }
}
