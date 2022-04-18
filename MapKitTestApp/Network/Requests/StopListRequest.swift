//
//  StopListRequest.swift
//  MapKitTestApp
//
//  Created by Oleg Stepanov on 15.04.2022.
//

import Foundation

struct StopListRequest: DataRequest {
    var baseUrl: String {
        "https://api.mosgorpass.ru/v8.2/stop"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    typealias Response = StopsRaw
}
