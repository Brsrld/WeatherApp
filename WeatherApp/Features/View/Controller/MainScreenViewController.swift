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
        label.text = "Nearest Locations"
        return label
    }()
    
    private let nearestCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Nearest City's"
        return label
    }()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        locationManagerSetup()
        initDelegate()
        apiService()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nearestLocationsCollectionView.contentSize = CGSize(width: nearestLocationsCollectionView.frame.width, height:  UIScreen.main.bounds.height)
        cityListCollectionView.contentSize = CGSize(width: cityListCollectionView.frame.width, height:  UIScreen.main.bounds.height)
    }
    
    //MARK: Functions
    
    private func locationManagerSetup() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
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
        print(urlLocation!)
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
            print(error ?? "")
        }, url: Constants.locaionURL + Constants.latlongExtension + "\(urlLocation ?? "37.785834,-122.40641")")
    }
    
    private func onlyCitys() {
        for index in 0..<allLocations.count {
            if allLocations[index].location_type == "City" {
                self.allCitys.append(self.allLocations[index])
            }
        }
    }
    
    func setupUI() {
        
        view.addSubview(nearestLocationsCollectionView)
        view.addSubview(cityListCollectionView)
        view.addSubview(nearestLocationsLabel)
        view.addSubview(nearestCityLabel)
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Main Screen"
        
        nearestLocationsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        nearestLocationsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nearestLocationsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        nearestLocationsLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 15).isActive = true
        
        nearestLocationsCollectionView.topAnchor.constraint(equalTo: nearestLocationsLabel.bottomAnchor).isActive = true
        nearestLocationsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        nearestLocationsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        nearestLocationsCollectionView.heightAnchor.constraint(equalToConstant: view.frame.height / 6).isActive = true
        
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



