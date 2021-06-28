//
//  MainMenuCollectionViewCell.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 26.06.2021.
//

import UIKit
import Kingfisher

class MainMenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: View Properties
    
    private var locationImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private var cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .orange
        label.numberOfLines = 0
        return label
    }()
    
    private var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .orange
        label.numberOfLines = 0
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupUI()
        shadowForContentView()
    }
    
    // MARK: Functions
    
    private func setupUI() {
        
        contentView.frame = CGRect(x: 0, y: 10, width: contentView.frame.size.width, height: contentView.frame.size.height - 10)
        
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(locationImage)
        contentView.backgroundColor = .orange
        
        NSLayoutConstraint.activate([
            
            cityNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            cityNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            cityNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            cityNameLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height / 5),
            
            locationImage.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor,constant: 5),
            locationImage.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 5),
            locationImage.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -75),
            locationImage.heightAnchor.constraint(equalToConstant: contentView.frame.height / 1.7),
            
            distanceLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor),
            distanceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 95),
            distanceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -5),
            distanceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func shadowForContentView() {
        layer.cornerRadius  = 10
        contentView.layer.cornerRadius = layer.cornerRadius
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    //MARK: Configure Cell
    
    func configure (title: String, distance: Int, type:String) {
        cityNameLabel.text = title + Constants.nilValue + type
        distanceLabel.text = "Distance: \(distance/1000) km"
        if type == Constants.city {
            locationImage.image = UIImage(named: Constants.city)
        } else {
            locationImage.image = UIImage(named: Constants.location)
        }
    }
}
