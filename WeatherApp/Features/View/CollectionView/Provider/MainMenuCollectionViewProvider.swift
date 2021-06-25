//
//  MainMenuCollectionViewProvider.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 26.06.2021.
//

import Foundation
import UIKit

//MARK: Protocols

protocol MainMenuCollectionViewProtocol {
    func update (items: [Location])
}

protocol MainMenuCollectionViewOutputProtocol: AnyObject {
    func getNavCont() -> UINavigationController?
}

//MARK: CollectionView Functions

final class MainMenuCollectionView: NSObject{
    
    private lazy var items: [Location] = []
    
    weak var delegate: MainMenuCollectionViewOutputProtocol?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let dataCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.mainMenuCollectionViewCellID, for: indexPath) as? MainMenuCollectionViewCell {
            dataCell.configure(title: items[indexPath.row].title, distance: items[indexPath.row].distance)
            cell = dataCell
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60
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
        return CGSize(width: width, height: height)
    }
}

//MARK:  - UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout

extension MainMenuCollectionView: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {}

//MARK:  - MainMenuCollectionViewProtocol

extension MainMenuCollectionView: MainMenuCollectionViewProtocol {
    
    func update (items: [Location]) {
        self.items = items
    }
}
