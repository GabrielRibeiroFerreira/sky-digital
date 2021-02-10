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
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.imageView)
        self.addSubview(self.nameLabel)
        
        self.internalConstraints = [
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.imageView.heightAnchor.constraint(equalToConstant: 150),
            self.imageView.widthAnchor.constraint(equalTo: self.heightAnchor, constant: CGFloat(2.0/3.0)),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 4),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
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
