//
//  StopListViewModel.swift
//  MapKitTestApp
//
//  Created by Oleg Stepanov on 15.04.2022.
//

import Foundation
import UIKit

protocol StopListViewModelProtocol {
    var stops: [Stop] { get }
    func fetchStops(completion: @escaping() -> Void)
    func makeDetailViewController(at indexPath: IndexPath) -> UIViewController
}

final class StopListViewModel: StopListViewModelProtocol {
    var stops: [Stop] = []
    var busStopService: BusStopServiceProtocol
    
    init(busStopService: BusStopServiceProtocol) {
        self.busStopService = busStopService
    }
    
    func fetchStops(completion: @escaping() -> Void) {
        busStopService.fetchStopList { stops in
            self.stops = stops
            completion()
        }
    }
    
    func makeDetailViewController(at indexPath: IndexPath) -> UIViewController {
        let stopId = stops[indexPath.row].id
        let viewModel = StopDetailViewModel(stopId: stopId, busStopService: busStopService)
        return StopDetailViewController(viewModel: viewModel)
    }
}
