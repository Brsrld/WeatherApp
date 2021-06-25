//
//  MainScreenViewController.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 25.06.2021.
//

import UIKit
import CoreLocation

class MainScreenViewController: UIViewController {

    private let locationManager = CLLocationManager()
    private var urlLocation: String?
    private let service: ServiceProtocol = Service()
    private let mainMenuCollectionView: MainMenuCollectionView = MainMenuCollectionView()
    
    let cityListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MainMenuCollectionViewCell.self, forCellWithReuseIdentifier: Constants.mainMenuCollectionViewCellID)
        cv.backgroundColor = .systemBackground
        cv.tag = 0
        return cv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .blue
        label.text = "Videos"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        initDelegate()
        apiService()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cityListCollectionView.contentSize = CGSize(width: cityListCollectionView.frame.width, height:  UIScreen.main.bounds.height)
    }
    
    func initDelegate () {
        locationManager.delegate = self
        locationManager.requestLocation()
        cityListCollectionView.delegate = mainMenuCollectionView
        cityListCollectionView.dataSource = mainMenuCollectionView
        mainMenuCollectionView.delegate = self
    }
    
    func apiService() {
        service.fethAllPosts(onSuccess: { models in
            self.mainMenuCollectionView.update(items: models)
            self.cityListCollectionView.reloadData()
        }, onFail: { error in
            print(error ?? "")
        }, latLong: urlLocation ?? "36.58718,36.17347")
    }
    
    func setupUI() {
        
        view.addSubview(cityListCollectionView)
        view.backgroundColor = .white
        
        cityListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cityListCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        cityListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cityListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK:  - CLLocationManagerDelegate

extension MainScreenViewController: CLLocationManagerDelegate {
    
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        // Handle changes if location permissions
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        // Handle failure to get a user’s location
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
           let location = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
            urlLocation = location
            print(urlLocation ?? "")
            // Handle location update
        }
    }
}
//MARK:  - MainMenuCollectionViewOutputProtocol

extension MainScreenViewController: MainMenuCollectionViewOutputProtocol {
    func getNavCont() -> UINavigationController? {
        return navigationController
    }
}



