//
//  PuppyCell.swift
//  PuppyGram
//
//  Created by Kerby Jean on 5/11/21.
//

import UIKit
import SDWebImage

class PuppyCell: UICollectionViewCell {
    
    // MARK: UI Elements
    var imageView = UIImageView()
    var alphaView = UIView()
    var nameLabel = UILabel()
    var dateLabel = UILabel()
    
    // MARK: Properties
    static var identifier: String {
        return String(describing: self)
    }
    
    var puppyItem: Item? {
        didSet {
            if let mediaUrl = puppyItem?.media.m {
                imageView.sd_setImage(with: URL(string: mediaUrl))
            } 
            nameLabel.text = puppyItem?.title.capitalizingFirstLetter() ?? "Unknown"
            dateLabel.text = puppyItem?.dateTaken
            
            if puppyItem?.dateTaken != nil {
                let dateString = puppyItem?.published ?? ""
                let date = Date()
                let dateFormatter2 = DateFormatter(format: dateString)
                dateFormatter2.dateStyle = .medium
                dateFormatter2.timeStyle = .medium
                dateLabel.text = "\(date.toString(dateFormatter: dateFormatter2)!)"
            } else {
                dateLabel.text = "No date available"
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func setupViews() {
        
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(dateLabel)
        imageView.addSubview(alphaView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        alphaView.backgroundColor = .alpha
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        alphaView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20.0),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20.0),
            imageView.heightAnchor.constraint(equalToConstant: self.frame.height/1.5),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            alphaView.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            alphaView.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6.0),
            nameLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4.0),
            dateLabel.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            dateLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
        ])
        
        imageView.layer.cornerRadius = 15
    }
}
