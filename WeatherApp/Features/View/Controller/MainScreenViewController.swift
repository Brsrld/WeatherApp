//
//  MainScreenViewController.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 25.06.2021.
//

import UIKit
import CoreLocation

class MainScreenViewController: UIViewController {
    
    //MARK: Variables
    
    private let locationManager = CLLocationManager()
    private var urlLocation: String?
    private var allCitys: [Location] = []
    private var allLocations: [Location] = []
    
    private var mainMenuViewModel: MainMenuViewModelProtocol = MainMenuViewModel()
    private let nearestLocationCollectionView: NearestLocationCollectionView = NearestLocationCollectionView()
    private let nearestCityCollectionView: NearestCityCollectionView = NearestCityCollectionView()
    
    let nearestLocationsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MainMenuCollectionViewCell.self, forCellWithReuseIdentifier: Constants.mainMenuCollectionViewCellID)
        cv.backgroundColor = .systemBackground
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.tag = 0
        return cv
    }()
    
    let cityListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(NearestCitysCollectionViewCell.self, forCellWithReuseIdentifier: Constants.nearestCitysCollectionViewCellID)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.tag = 0
        return cv
    }()
    
    private let nearestLocationsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = Constants.nearestLocation
        return label
    }()
    
    private let nearestCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = Constants.nearestCitys
        return label
    }()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkCheck()
        initDelegate()
        setupUI()
        locationManagerSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nearestLocationsCollectionView.contentSize = CGSize(width: nearestLocationsCollectionView.frame.width, height:  UIScreen.main.bounds.height)
        cityListCollectionView.contentSize = CGSize(width: cityListCollectionView.frame.width, height:  UIScreen.main.bounds.height)
    }
    
    //MARK: Functions
    
    private func networkCheck() {
        if NetworkMonitor.shared.isConnected {
            print(Constants.internetConnected)
        } else {
            print(Constants.internetNotConnected)
        }
    }
    
    private func locationManagerSetup() {
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
    
    func initDelegate () {
        
        nearestLocationsCollectionView.delegate = nearestLocationCollectionView
        nearestLocationsCollectionView.dataSource = nearestLocationCollectionView
        
        cityListCollectionView.delegate = nearestCityCollectionView
        cityListCollectionView.dataSource = nearestCityCollectionView
        
        nearestLocationCollectionView.delegate = self
        nearestCityCollectionView.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.urlLocation = "\(locValue.latitude),\(locValue.longitude)"
        self.cityListCollectionView.reloadData()
        apiService()
    }
    
    func apiService() {
        mainMenuViewModel.service(onSuccess: { [weak self]  models in
            guard let self = self else { return }
            self.allLocations = models
            self.onlyCitys()
            self.nearestCityCollectionView.update(items: self.allCitys)
            self.cityListCollectionView.reloadData()
            self.nearestLocationCollectionView.update(items: models)
            self.nearestLocationsCollectionView.reloadData()
        }, onFail: { error in
            print(error ?? Constants.nilValue)
        }, url: Constants.locaionURL + Constants.latlongExtension + "\(urlLocation ?? Constants.defaultLattLong)")
    }

    private func onlyCitys() {
        for index in 0..<allLocations.count {
            if allLocations[index].location_type == Constants.city {
                self.allCitys.append(self.allLocations[index])
            }
        }
    }
    
    func setupUI() {
 
        view.addSubviews(nearestLocationsCollectionView,cityListCollectionView,nearestLocationsLabel,nearestCityLabel)
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = false
        title = Constants.mainScreenTitle
        
        nearestLocationsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nearestLocationsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nearestLocationsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        nearestLocationsLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 15).isActive = true
        
        nearestLocationsCollectionView.topAnchor.constraint(equalTo: nearestLocationsLabel.bottomAnchor,constant: -20).isActive = true
        nearestLocationsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        nearestLocationsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        nearestLocationsCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height / 4.7).isActive = true
        
        nearestCityLabel.topAnchor.constraint(equalTo: nearestLocationsCollectionView.bottomAnchor).isActive = true
        nearestCityLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nearestCityLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        nearestCityLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 15).isActive = true
        
        cityListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        cityListCollectionView.topAnchor.constraint(equalTo: nearestCityLabel.bottomAnchor,constant: 10).isActive = true
        cityListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        cityListCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK:  - CLLocationManagerDelegate

extension MainScreenViewController: CLLocationManagerDelegate {}

//MARK:  - NearestLocationCollectionViewOutputProtocol

extension MainScreenViewController: NearestLocationCollectionViewOutputProtocol{}

//MARK:  - NearestCityCollectionViewOutputProtocol

extension MainScreenViewController: NearestCityCollectionViewOutputProtocol {
    func getNavCont() -> UINavigationController? {
        return navigationController
    }
}



