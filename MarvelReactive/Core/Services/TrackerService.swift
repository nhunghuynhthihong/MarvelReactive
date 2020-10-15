//
//  TrackerService.swift
//  MarvelReactive
//
//  Created by Ecko Huynh on 10/14/20.
//

import Foundation
enum TrackEventType {
    case listView
}

protocol TrackerType {
    func log(type: TrackEventType)
}

final class TrackerService: TrackerType {
    
    func log(type: TrackEventType) {
        // do something
    }
}
