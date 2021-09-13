//
//  DrinkImageViewModel.swift
//  DrinksOrderApp
//
//  Created by HAHA on 1/8/2021.
//

import Foundation
import Combine
import SwiftUI

class DrinkImageViewModel: ObservableObject{
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    var cancellables = Set<AnyCancellable>()
    let urlString: String
    let keyString: String
    let imageManager = PhotoCacheManager.instance
    
    init(url: String, key: String){
        urlString = url
        keyString = key
        getImage()
    }
    
    func getImage(){
        if let savedImage = imageManager.get(key: keyString){
            image = savedImage
            print("Getting saved image")
        }else{
            downloadImage()
            print("Downloading image")
        }
    }
    
    func downloadImage(){
        isLoading = true
        guard let url = URL(string: urlString) else{
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .map{UIImage(data: $0.data)}
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard let self = self,
                      let finalImage = returnedImage else{return}
                self.image = finalImage
                self.imageManager.save(key: self.keyString, value: finalImage)
            }
            .store(in: &cancellables)
    }
}
