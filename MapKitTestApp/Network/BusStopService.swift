//
//  BusStopService.swift
//  MapKitTestApp
//
//  Created by Oleg Stepanov on 15.04.2022.
//

import Foundation

protocol BusStopServiceProtocol {
    func fetchStopList(completion: @escaping([Stop]) -> Void)
    func fetchDetailStop(stopId: String, completion: @escaping(Result<StopRaw,Error>) -> Void)
}

final class BusStopService: BusStopServiceProtocol {
    private let networkService = NetworkCore.instance
    
    func fetchStopList(completion: @escaping ([Stop]) -> Void) {
        let stopRequest = StopListRequest()
        networkService.request(stopRequest) { result in
            switch result {
            case .success(let response):
                completion(response.data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchDetailStop(stopId: String, completion: @escaping(Result<StopRaw,Error>) -> Void) {
        let stopDetailRequest = StopDetailRequest(stopId: stopId)
        networkService.request(stopDetailRequest) { result in
            completion(result)
        }
    }
}
