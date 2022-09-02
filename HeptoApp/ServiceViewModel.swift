//
//  ServiceViewModel.swift
//  HeptoApp
//
//  Created by iOS on 25/08/22.
//

import Foundation
class ServiceViewModel{
    func getServices()->[ServiceModel] {
        return [ServiceModel(title: "Ride", image: "Cab", service: [Service(title: "Taxi Ride", image: "Taxiride"),Service(title: "Bike Ride", image: "Bikeride"),Service(title: "Ambulance Ride", image: "Ambulance"),Service(title: "Airport Ride", image: "Airportride")]),ServiceModel(title: "Delivery", image: "Delivery", service: [Service(title: "Food Delivery", image: "Food"),Service(title: "Pharmacy Delivery", image: "Pharmacy"),Service(title: "Supermarket Delivery", image: "Supermarket"),Service(title: "Other Delivery", image: "Other")]),ServiceModel(title: "School", image: "School", service: [Service(title: "Parent", image: "Parent"),Service(title: "Student", image: "Student")]),ServiceModel(title: "EV Charging", image: "Charging", service: [Service(title: "Fixed EV Charging Point", image: "FixedEV"),Service(title: "Mobile EV Charging Point", image: "MobileEV")]),ServiceModel(title: "EV Investor", image: "Investor", service: [Service(title: "Fixed EV Charging Point Investor", image: "FixedEV"),Service(title: "Mobile EV Charging Point Investor", image: "MobileEV"),Service(title: " EV Ambulance Investor", image: "Ambulance"),Service(title: "EV Taxi Investor", image: "TaxiEV")])]
    }
}
