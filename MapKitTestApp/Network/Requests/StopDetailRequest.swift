//
//  StopDetailRequest.swift
//  MapKitTestApp
//
//  Created by Oleg Stepanov on 15.04.2022.
//

import Foundation

struct StopDetailRequest: DataRequest {
    
    var stopId: String
    init(stopId: String) {
        self.stopId = stopId
    }
    
    var baseUrl: String {
        "https://api.mosgorpass.ru/v8.2/stop/\(stopId)"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    typealias Response = StopRaw
}
