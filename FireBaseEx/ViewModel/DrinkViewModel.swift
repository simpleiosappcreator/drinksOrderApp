//
//  DownloadDrinksInfoViewModel.swift
//  DrinksOrderApp
//
//  Created by HAHA on 1/8/2021.
//

import Foundation
import Combine

class DrinkViewModel: ObservableObject{
    @Published var drinks: [Drink] = []
    let dataService = DownloadingDataService.instance
    var cancellables = Set<AnyCancellable>()
    
    init(){
        addData()
    }
    
    func addData(){
        dataService.$downloadedData
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink { [weak self] returnedData in
                self?.drinks = returnedData
            }
            .store(in: &cancellables)
    }
}
