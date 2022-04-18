//
//  StopDetailViewModel.swift
//  MapKitTestApp
//
//  Created by Oleg Stepanov on 15.04.2022.
//

import Foundation

final class StopDetailViewModel {
    var stopDetail: StopRaw?
    let busStopService: BusStopServiceProtocol
    let stopId: String
    init(stopId: String, busStopService: BusStopServiceProtocol) {
        self.stopId = stopId
        self.busStopService = busStopService
    }
    
    func fetchDetailStop(completion: @escaping(String?) -> Void) {
        busStopService.fetchDetailStop(stopId: stopId) { result in
            switch result {
            case .success(let response):
                self.stopDetail = response
                completion(nil)
            case .failure:
                let errorText = "Ошибка получения данных"
                completion(errorText)
            }
        }
    }
    
    func makeBottomSheet() -> BottomSheetViewController {
        let bottomSheetViewModel = BottomSheetViewModel(stopDetail: stopDetail)
        return BottomSheetViewController(viewModel: bottomSheetViewModel)
    }
}
