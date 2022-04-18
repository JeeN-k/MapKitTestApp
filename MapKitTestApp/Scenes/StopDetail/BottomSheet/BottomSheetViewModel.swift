//
//  BottomSheetViewModel.swift
//  MapKitTestApp
//
//  Created by Oleg Stepanov on 18.04.2022.
//

import Foundation

final class BottomSheetViewModel {
    var stopDetail: StopRaw?
    
    init(stopDetail: StopRaw?) {
        self.stopDetail = stopDetail
    }
    
    func viewModelForCell(at indexPath: IndexPath) -> RouteCellViewModel? {
        guard let route = stopDetail?.routePath[indexPath.item] else { return nil }
        return RouteCellViewModel(route: route)
    }
}
