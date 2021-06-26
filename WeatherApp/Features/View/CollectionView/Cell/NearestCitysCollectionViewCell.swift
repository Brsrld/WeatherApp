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
    
    private var cityNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
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
        label.textAlignment = .center
        label.backgroundColor = .white
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
        contentView.backgroundColor = .white
        
        contentView.frame = CGRect(x: 0, y: 10, width: contentView.frame.size.width, height: contentView.frame.size.height - 10)
        cityNameLabel.frame = CGRect(x: 0, y:10, width: contentView.frame.size.width, height: 50)
        distanceLabel.frame = CGRect(x: 0, y:60, width: contentView.frame.size.width, height: 50)
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
    }
}
