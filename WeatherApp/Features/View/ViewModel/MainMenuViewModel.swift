//
//  MainMenuViewModel.swift
//  WeatherApp
//
//  Created by Baris Saraldi on 26.06.2021.
//

import Foundation

//MARK: Protocols

protocol MainMenuViewModelProtocol {
    func service(onSuccess: @escaping ([Location]) -> Void, onFail: @escaping (String?) -> Void, url:String)
}

//MARK: Model Logic

final class MainMenuViewModel {
    
    private let mainMenuViewModelService: ServiceProtocol = Service()
    
    func service(onSuccess: @escaping ([Location]) -> Void, onFail: @escaping (String?) -> Void, url:String) {
        mainMenuViewModelService.fethAllPosts(onSuccess: onSuccess, onFail: onFail, url: url)
    }
}

//MARK:  - MainMenuViewModelProtocol

extension MainMenuViewModel: MainMenuViewModelProtocol {}
