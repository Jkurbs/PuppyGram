//
//  PuppyCell.swift
//  PuppyGram
//
//  Created by Kerby Jean on 5/11/21.
//

import UIKit
import SDWebImage

class PuppyCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    var alphaView = UIView()
    var nameLabel = UILabel()
    var dateLabel = UILabel()
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var puppy: Item? {
        didSet {
            if let mediaUrl = puppy?.media.m {
                imageView.sd_setImage(with: URL(string: mediaUrl))
            } else {
                imageView.image = UIImage(named: "")
            }
            nameLabel.text = puppy?.title
            dateLabel.text = puppy?.dateTaken
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(dateLabel)
        imageView.addSubview(alphaView)
        imageView.addSubview(likeButton)

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        alphaView.backgroundColor = .alpha
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
                
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        alphaView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let boldLargeConfig = UIImage.SymbolConfiguration(pointSize: UIFont.systemFontSize, weight: .bold, scale: .large)
        let smallConfig = UIImage.SymbolConfiguration(scale: .large)
        let boldSmallConfig = boldLargeConfig.applying(smallConfig)
        
        let heartImage = UIImage(systemName: "heart", withConfiguration: boldSmallConfig)
        let redHeartImage = heartImage?.withTintColor(.white, renderingMode: .alwaysOriginal)
        likeButton.setImage(redHeartImage, for: .normal)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: self.frame.height/1.5),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            alphaView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            alphaView.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            nameLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            dateLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            dateLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
        ])
        
        imageView.layer.cornerRadius = 15
        imageView.backgroundColor = .red
    }
}
