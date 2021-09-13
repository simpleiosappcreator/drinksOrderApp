//
//  DownloadingDataService.swift
//  DrinksOrderApp
//
//  Created by HAHA on 1/8/2021.
//

import Foundation
import Combine
import Firebase

class DownloadingDataService: ObservableObject{
    static var instance = DownloadingDataService()
    @Published var downloadedData: [Drink] = []
    var cancellables = Set<AnyCancellable>()
    var db = Firestore.firestore()
    
    init(){
        downloadData()
    }
    
    func downloadData(){
        // Using firebase
        db.collection("drinksInfo").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else{
                print("No documents")
                return
            }
            self.downloadedData = documents.map{ QueryDocumentSnapshot -> Drink in
                let data = QueryDocumentSnapshot.data()
                
                let id = data["id"] as? Int ?? 0
                let name = data["name"] as? String ?? ""
                let price = data["price"] as? Int ?? 0
                let availableStatus = data["availableStatus"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let imageUrl = data["imageUrl"] as? String ?? ""
                
                return Drink(id: id, name: name, price: price, availableStatus: availableStatus, description: description, imageUrl: imageUrl)
            }
        }
        
        // Using Combine
//        guard let url = URL(string: "https://jsonkeeper.com/b/A6EP") else{return}
//
//        URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .background))
//            .receive(on: DispatchQueue.main)
//            .tryMap(handleOutput)
//            .decode(type: [Drink].self, decoder: JSONDecoder())
//            .sink { completion in
//                switch completion{
//                case .finished:
//                    break
//                case .failure(let error):
//                    print("Error downloading data. \(error)")
//                }
//            } receiveValue: { [weak self] returnedData in
//                self?.downloadedData = returnedData
//            }
//            .store(in: &cancellables)

    }
    
    // Using Combine
//    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data{
//        guard let response = output.response as? HTTPURLResponse,
//              response.statusCode >= 200 && response.statusCode < 300 else{
//            throw URLError(.badServerResponse)
//        }
//        return output.data
//    }
}
