//
//  StopRaw.swift
//  MapKitTestApp
//
//  Created by Oleg Stepanov on 15.04.2022.
//

import Foundation

struct StopRaw: Decodable {
    var name: String
    var lat: Double
    var lon: Double
    var transportTypes: [String]
    var routePath: [Route]
}

struct Route: Decodable {
    var number: String
    var timeArrival: [String]
    var color: String
    var fontColor: String
    var byTelemetry: Int
}
