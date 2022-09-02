//
//  ActivityViewModel.swift
//  HeptoApp
//
//  Created by iOS on 25/08/22.
//

import Foundation
class ActivityViewModel{
    
    func getAvailability()->[ActivityModel]{
        return [ActivityModel(day: "SUN", timings: [Timings(start: "10", end: "11")]),ActivityModel(day: "MON", timings: [Timings(start: "10", end: "11")]),ActivityModel(day: "TUE", timings: [Timings(start: "10", end: "11")]),ActivityModel(day: "WED", timings: [Timings(start: "10", end: "11")]),ActivityModel(day: "THU", timings: [Timings(start: "10", end: "11")]),ActivityModel(day: "FRI", timings: [Timings(start: "10", end: "11")]),ActivityModel(day: "SAT", timings: [Timings(start: "10", end: "11")])]
    }
}
