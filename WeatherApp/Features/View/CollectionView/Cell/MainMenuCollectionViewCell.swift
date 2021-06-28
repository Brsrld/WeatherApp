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
        
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(locationImage)
        contentView.backgroundColor = .orange
        
        contentView.frame = CGRect(x: 0, y: 10, width: contentView.frame.size.width, height: contentView.frame.size.height - 10)
        
        locationImage.frame = CGRect(x: 5, y:0, width: contentView.frame.size.width / 2.5 , height: contentView.frame.size.height)
        cityNameLabel.frame = CGRect(x: locationImage.frame.size.width + 10, y:10, width: contentView.frame.size.width - locationImage.frame.size.width - 10, height: 50)
        distanceLabel.frame = CGRect(x: locationImage.frame.size.width + 10, y:60, width: contentView.frame.size.width - locationImage.frame.size.width - 10, height: 50)
    }
    
    private func shadowForContentView() {
        layer.cornerRadius  = 10
        contentView.layer.cornerRadius = layer.cornerRadius
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    //MARK: Configure Cell
    
    func configure (title: String, distance: Int, type:String) {
        cityNameLabel.text = title + " " + type
        distanceLabel.text = "Distance: \(distance/1000) km"
        if type == "City" {
            locationImage.image = UIImage(named: "city")
        } else {
            locationImage.image = UIImage(named: "location")
        }
        
    }
}
