//
//  StopsRaw.swift
//  MapKitTestApp
//
//  Created by Oleg Stepanov on 15.04.2022.
//

import Foundation

struct StopsRaw: Decodable {
    var data: [Stop]
}

struct Stop: Decodable {
    var id: String
    var name: String
}
