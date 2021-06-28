//
//  CityDetailViewController.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 26.06.2021.
//

import UIKit
import Charts
import Network

class CityDetailViewController: UIViewController {
    
    //MARK: Variables
    
    var cityID: Location?
    private var barChart = BarChartView()
    private var barChartData: [Double] = []
    private var allData: [CityWeather] = []
    let monitor = NWPathMonitor()
    
    private var cityDetailViewModel: CityDetailViewModelProtocol = CityDetailViewModel()
    private let cityDetailCollectionView: CityDetailCollectionView = CityDetailCollectionView()
    
    let cityDetailsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CityDetailCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cityDetailCollectionViewCellID)
        cv.backgroundColor = .systemBackground
        cv.tag = 0
        return cv
    }()
    
    private let weeklyWeatherForecastLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Weekly Weather Forecast"
        return label
    }()
    
    private let weeklyTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Weekly Temp"
        return label
    }()
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkCheck()
        apiService()
        setupUI()
        initDelegate()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cityDetailsCollectionView.contentSize = CGSize(width: cityDetailsCollectionView.frame.width, height:  UIScreen.main.bounds.height)
    }
    
    //MARK: Functions
    
    private func networkCheck() {
        if NetworkMonitor.shared.isConnected {
            print("Device connected to internet")
        } else {
            print("Device did not connected to internet")
        }
    }
    
    private func initDelegate () {
        cityDetailsCollectionView.delegate = cityDetailCollectionView
        cityDetailsCollectionView.dataSource = cityDetailCollectionView
        cityDetailCollectionView.delegate = self
        barChart.delegate = self
    }
    
    private func apiService() {
        cityDetailViewModel.service(url: Constants.locaionURL + "\(cityID!.woeid)") { [weak self]  models in
            guard let self = self else { return }
            self.allData = models
            self.onlyTemp()
            self.cityDetailCollectionView.update(items: models)
            self.cityDetailsCollectionView.reloadData()
        } onFail: { error in
            print(error ?? "")
        }
    }
    
    private func onlyTemp() {
        for index in 0..<allData.count {
            self.barChartData.append(self.allData[index].the_temp)
        }
        barChartSetup()
    }
    
    private func barChartSetup() {
        
        var entiries = [BarChartDataEntry]()
        
        for index in 0..<barChartData.count {
            entiries.append(BarChartDataEntry(x: barChartData[index].rounded(), y: barChartData[index].rounded()))
        }
        
        let set = BarChartDataSet(entries: entiries)
        set.colors = ChartColorTemplates.joyful()
        let data = BarChartData(dataSet: set)
        barChart.data = data
    }
    
    private func setupUI() {
        
        view.addSubview(cityDetailsCollectionView)
        view.addSubview(barChart)
        view.addSubview(weeklyTempLabel)
        view.addSubview(weeklyWeatherForecastLabel)
        view.backgroundColor = .white
        barChart.translatesAutoresizingMaskIntoConstraints = false
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "City Detail"
        
        weeklyTempLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        weeklyTempLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10).isActive = true
        weeklyTempLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        weeklyTempLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 20).isActive = true
        
        barChart.topAnchor.constraint(equalTo: weeklyTempLabel.bottomAnchor,constant: 10).isActive = true
        barChart.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        barChart.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        barChart.heightAnchor.constraint(equalToConstant: view.frame.height/3).isActive = true
        
        weeklyWeatherForecastLabel.topAnchor.constraint(equalTo: barChart.bottomAnchor,constant: 10).isActive = true
        weeklyWeatherForecastLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10).isActive = true
        weeklyWeatherForecastLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        weeklyWeatherForecastLabel.heightAnchor.constraint(equalToConstant: view.frame.height / 20).isActive = true
        
        cityDetailsCollectionView.topAnchor.constraint(equalTo: weeklyWeatherForecastLabel.bottomAnchor,constant: 10).isActive = true
        cityDetailsCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cityDetailsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cityDetailsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

//MARK:  - CityDetailCollectionViewOutputProtocol

extension CityDetailViewController: CityDetailCollectionViewOutputProtocol {}

//MARK:  - ChartViewDelegate

extension CityDetailViewController: ChartViewDelegate {}
