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
    
    private var cityImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.backgroundColor = .black
        iv.clipsToBounds = true
        return iv
    }()
    
    private var cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.backgroundColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupUI()
        shadowForContentView()
        shadowForImage()
    }
    
    // MARK: Functions
    
    private func setupUI() {
        
        contentView.addSubview(cityImage)
        contentView.addSubview(cityNameLabel)
        contentView.addSubview(distanceLabel)
        contentView.backgroundColor = .white
        
        contentView.frame = CGRect(x: 0, y: 60, width: contentView.frame.size.width, height: contentView.frame.size.height)
        cityImage.frame = CGRect(x: 0, y: -50, width: contentView.frame.size.width / 2.5, height: contentView.frame.size.height + 50)
        cityNameLabel.frame = CGRect(x: cityImage.frame.width + 10, y:10, width: contentView.frame.size.width - cityImage.frame.width - 10, height: 50)
        distanceLabel.frame = CGRect(x: cityImage.frame.width + 10, y:60, width: contentView.frame.size.width - cityImage.frame.width - 10, height: 50)
    }
    
    private func shadowForContentView() {
        layer.cornerRadius  = 10
        contentView.layer.cornerRadius = layer.cornerRadius
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    private func shadowForImage() {
        cityImage.layer.cornerRadius = 10
        cityImage.layer.shadowOpacity = 1
        cityImage.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    //MARK: Configure Cell
    
    func configure (title: String, distance: Int) {
        cityNameLabel.text = title
        distanceLabel.text = "\(distance/1000) km"
    }
}
