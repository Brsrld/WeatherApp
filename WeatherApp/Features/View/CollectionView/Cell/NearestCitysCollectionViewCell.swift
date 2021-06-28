//
//  NearestCitysCollectionViewCell.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 26.06.2021.
//

import UIKit
import Kingfisher

class NearestCitysCollectionViewCell: UICollectionViewCell {
    
    // MARK: View Properties
    
    private var cityImage: UIImageView = {
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
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
        label.backgroundColor = .systemBlue
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
        contentView.addSubview(cityImage)
        
        contentView.backgroundColor = .systemBlue
        
        contentView.frame = CGRect(x: 0, y: 10, width: contentView.frame.size.width, height: contentView.frame.size.height)
        cityImage.frame = CGRect(x: 10, y:10, width: contentView.frame.size.width / 2, height: contentView.frame.size.height - 20)
        cityNameLabel.frame = CGRect(x: cityImage.frame.size.width + 10, y:10, width: contentView.frame.size.width - cityImage.frame.size.width - 10, height: 50)
        distanceLabel.frame = CGRect(x: cityImage.frame.size.width + 10, y:90, width: contentView.frame.size.width - cityImage.frame.size.width - 10, height: 50)
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
        cityImage.image = UIImage(named: "city")
    }
}
