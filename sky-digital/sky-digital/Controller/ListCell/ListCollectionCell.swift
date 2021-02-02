//
//  ListCollectionCell.swift
//  sky-digital
//
//  Created by Ribeiro Ferreira on 01/02/21.
//

import UIKit

public class ListCollectionCell: UICollectionViewCell {
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
    private var imageView: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    private var nameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var internalConstraints: [NSLayoutConstraint] = []
    
    private func setConstraints() {
        NSLayoutConstraint.deactivate(self.internalConstraints)
        
        self.internalConstraints = [
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
        ]
        
        NSLayoutConstraint.activate(self.internalConstraints)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setConstraints()
    }
}
