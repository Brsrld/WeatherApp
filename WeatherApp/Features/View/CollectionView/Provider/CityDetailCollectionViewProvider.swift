//
//  CityDetailCollectionViewProvider.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 26.06.2021.
//

import Foundation
import UIKit

//MARK: Protocols

protocol CityDetailCollectionViewProtocol {
    func update (items: [CityWeather])
}

protocol CityDetailCollectionViewOutputProtocol: AnyObject {}

//MARK: CollectionView Functions

final class CityDetailCollectionView: NSObject{
    
    private lazy var items: [CityWeather] = []
    
    weak var delegate: CityDetailCollectionViewOutputProtocol?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let dataCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cityDetailCollectionViewCellID, for: indexPath) as? CityDetailCollectionViewCell {
            dataCell.configure(date: items[indexPath.row].applicable_date, temp: items[indexPath.row].the_temp, wind: items[indexPath.row].wind_speed, airPressure: items[indexPath.row].air_pressure, image: items[indexPath.row].weather_state_abbr)
            cell = dataCell
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 1.1
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let adjustedWidth = collectionViewWidth - spaceBetweenCells - sectionInsets
        let width: CGFloat = floor(adjustedWidth / columns)
        let height: CGFloat = width / 2
        return CGSize(width: width / 1.3, height: height / 1.5)
    }
}

//MARK:  - UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout

extension CityDetailCollectionView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {}

//MARK:  - MainMenuCollectionViewProtocol

extension CityDetailCollectionView: CityDetailCollectionViewProtocol {
    
    func update (items: [CityWeather]) {
        self.items = items
    }
}
