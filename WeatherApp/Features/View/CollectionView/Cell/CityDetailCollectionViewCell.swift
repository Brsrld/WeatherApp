//
//  CityDetailCollectionViewCell.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 26.06.2021.
//
import UIKit
import Kingfisher

class CityDetailCollectionViewCell: UICollectionViewCell {
    
    // MARK: View Properties
    
    private var weatherImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private var tempImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private var windImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private var airPressureImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private var dateImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private var dateLabel: UILabel = {
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
    
    private var tempLabel: UILabel = {
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
    
    private var windLabel: UILabel = {
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
    
    private var airPressureLabel: UILabel = {
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
        shadowForImage()
    }
    
    // MARK: Functions
    
    private func setupUI() {
        
        contentView.addSubview(weatherImage)
        contentView.addSubview(dateLabel)
        contentView.addSubview(tempLabel)
        contentView.addSubview(windLabel)
        contentView.addSubview(airPressureLabel)
        contentView.addSubview(tempImage)
        contentView.addSubview(windImage)
        contentView.addSubview(airPressureImage)
        contentView.addSubview(dateImage)
        contentView.backgroundColor = .systemBlue
        
        contentView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        weatherImage.frame = CGRect(x: 10, y: 20, width: contentView.frame.size.width / 2.5, height: contentView.frame.size.height - 40)
        tempImage.frame = CGRect(x: contentView.frame.size.width / 3, y: 10, width: weatherImage.frame.width, height: 25)
        windImage.frame = CGRect(x: contentView.frame.size.width / 3, y: 40, width: weatherImage.frame.width, height: 25)
        airPressureImage.frame = CGRect(x: contentView.frame.size.width / 3, y: 70, width: weatherImage.frame.width, height: 25)
        dateImage.frame = CGRect(x: contentView.frame.size.width / 3, y: 100, width: weatherImage.frame.width, height: 25)
        
        tempLabel.frame = CGRect(x: contentView.frame.size.width / 1.7, y: 10, width: weatherImage.frame.width - 10, height: 20)
        windLabel.frame = CGRect(x: contentView.frame.size.width / 1.7, y: 40, width: weatherImage.frame.width - 10, height: 20)
        airPressureLabel.frame = CGRect(x: contentView.frame.size.width / 1.7, y: 70, width: weatherImage.frame.width - 10, height: 20)
        dateLabel.frame = CGRect(x: contentView.frame.size.width / 1.7, y: contentView.frame.size.height - 25, width: weatherImage.frame.width - 10, height: 20)
    }
    
    private func shadowForContentView() {
        layer.cornerRadius  = 10
        contentView.layer.cornerRadius = layer.cornerRadius
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    private func shadowForImage() {
        weatherImage.layer.cornerRadius = 10
        weatherImage.layer.shadowOpacity = 1
        weatherImage.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    //MARK: Configure Cell
    
    func configure (date: String, temp: Double, wind: Double, airPressure: Double, image:String) {
        dateLabel.text = date
        weatherImage.kf.setImage(with: URL(string: Constants.weatherImageUrl + image + Constants.weatherImageUrlExtension))
        tempImage.image = UIImage(named: "thermometer")
        windImage.image = UIImage(named: "wind")
        airPressureImage.image = UIImage(named: "pressure")
        dateImage.image = UIImage(named: "schedule")
        tempLabel.text = "\(temp.rounded()) °C"
        windLabel.text = "\(wind.rounded()) km/h"
        airPressureLabel.text = "\(airPressure.rounded()) Pa"
    }
}
