//
//  NearestCityCollectionViewProvider.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 26.06.2021.
//

import Foundation
import UIKit

//MARK: Protocols

protocol NearestCityCollectionViewProtocol {
    func update (items: [Location])
}

protocol NearestCityCollectionViewOutputProtocol: AnyObject {
    func getNavCont() -> UINavigationController?
}

//MARK: CollectionView Functions

final class NearestCityCollectionView: NSObject{
    
    private lazy var items: [Location] = []
    
    weak var delegate: NearestCityCollectionViewOutputProtocol?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let dataCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.nearestCitysCollectionViewCellID, for: indexPath) as? NearestCitysCollectionViewCell {
            dataCell.configure(title: items[indexPath.row].title, distance: items[indexPath.row].distance, type: items[indexPath.row].location_type)
                cell = dataCell
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CityDetailViewController()
        vc.cityID = items[indexPath.row]
        delegate?.getNavCont()?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 0.6
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let adjustedWidth = collectionViewWidth - spaceBetweenCells - sectionInsets
        let width: CGFloat = floor(adjustedWidth / columns)
        let height: CGFloat = width / 2
        return CGSize(width: height, height: width / 4)
    }
}

//MARK:  - UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout

extension NearestCityCollectionView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {}

//MARK:  - NearestCityCollectionView

extension NearestCityCollectionView: NearestCityCollectionViewProtocol {
    
    func update (items: [Location]) {
        self.items = items
    }
}

