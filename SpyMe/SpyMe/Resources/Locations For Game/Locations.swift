//
//  Locations.swift
//  SpyMe
//
//  Created by Danny Navarro on 5/3/18.
//  Copyright © 2018 Danny Navarro. All rights reserved.
//

import Foundation


struct Locations {
    
    let locations: [String] = [ "Airplane",
                                "Antarctica",
                                "Bank",
                                "Beach",
                                "Bowling Alley",
                                "Casino",
                                "Castle",
                                "Church",
                                "Circus",
                                "Dentist Office",
                                "Zoo"]
    
    func getRandomLocation() -> String
    {
        let randomIndex = Int(arc4random_uniform(UInt32(locations.count)))
        return locations[randomIndex]
    }
}
