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
        iv.backgroundColor = .systemBlue
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
        
        contentView.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height)
        
        contentView.addSubview(weatherImage)
        contentView.addSubview(tempImage)
        contentView.addSubview(windImage)
        contentView.addSubview(airPressureImage)
        contentView.addSubview(dateImage)
        
        contentView.addSubview(tempLabel)
        contentView.addSubview(windLabel)
        contentView.addSubview(airPressureLabel)
        contentView.addSubview(dateLabel)
        
        contentView.backgroundColor = .systemBlue
        
        NSLayoutConstraint.activate([
            
            weatherImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            weatherImage.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 20),
            weatherImage.widthAnchor.constraint(equalToConstant: contentView.frame.width / 4),
            weatherImage.heightAnchor.constraint(equalToConstant: contentView.frame.height - 30),
            
            tempImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            tempImage.leftAnchor.constraint(equalTo: weatherImage.rightAnchor,constant: 50),
            tempImage.widthAnchor.constraint(equalToConstant: contentView.frame.width / 13),
            tempImage.heightAnchor.constraint(equalToConstant: contentView.frame.height / 5.5),
            
            tempLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            tempLabel.leftAnchor.constraint(equalTo: tempImage.rightAnchor,constant: 10),
            tempLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 5),
            tempLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height / 5.5),
            
            windImage.topAnchor.constraint(equalTo: tempImage.bottomAnchor,constant: 10),
            windImage.leftAnchor.constraint(equalTo: weatherImage.rightAnchor,constant: 50),
            windImage.widthAnchor.constraint(equalToConstant: contentView.frame.width / 13),
            windImage.heightAnchor.constraint(equalToConstant: contentView.frame.height / 5.5),
            
            windLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor,constant: 10),
            windLabel.leftAnchor.constraint(equalTo: windImage.rightAnchor,constant: 10),
            windLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 5),
            windLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height / 5.5),
            
            airPressureImage.topAnchor.constraint(equalTo: windImage.bottomAnchor,constant: 10),
            airPressureImage.leftAnchor.constraint(equalTo: weatherImage.rightAnchor,constant: 50),
            airPressureImage.widthAnchor.constraint(equalToConstant: contentView.frame.width / 13),
            airPressureImage.heightAnchor.constraint(equalToConstant: contentView.frame.height / 5.5),
            
            airPressureLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor,constant: 8),
            airPressureLabel.leftAnchor.constraint(equalTo: airPressureImage.rightAnchor,constant: 10),
            airPressureLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 5),
            airPressureLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height / 5.5),
            
            dateImage.topAnchor.constraint(equalTo: airPressureImage.bottomAnchor,constant: 10),
            dateImage.leftAnchor.constraint(equalTo: weatherImage.rightAnchor,constant: 50),
            dateImage.widthAnchor.constraint(equalToConstant: contentView.frame.width / 13),
            dateImage.heightAnchor.constraint(equalToConstant: contentView.frame.height / 5.5),
            
            dateLabel.topAnchor.constraint(equalTo: airPressureLabel.bottomAnchor,constant: 10),
            dateLabel.leftAnchor.constraint(equalTo: dateImage.rightAnchor,constant: 10),
            dateLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width / 4),
            dateLabel.heightAnchor.constraint(equalToConstant: contentView.frame.height / 5.5),
        ])
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
        tempImage.image = UIImage(named: Constants.thermometer)
        windImage.image = UIImage(named: Constants.wind)
        airPressureImage.image = UIImage(named: Constants.pressure)
        dateImage.image = UIImage(named: Constants.schedule)
        tempLabel.text = "\(temp.rounded()) °C"
        windLabel.text = "\(wind.rounded()) km/h"
        airPressureLabel.text = "\(airPressure.rounded()) Pa"
    }
}
