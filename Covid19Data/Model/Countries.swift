//
//  Countries.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 10/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import Foundation

struct Countries {
    var name: String
    var slug: String
    var code: String
    var flag: String
    
    static func configureCountries() -> [Countries] {
        var countries: [Countries] = []
        
        let australia = Countries(name: "Australia", slug: "australia", code: "au", flag: "🇦🇺")
        let uk = Countries(name: "United Kingdom", slug: "united-kingdom", code: "gb", flag: "🇬🇧")
        let usa = Countries(name: "United States", slug: "united-states-of-america", code: "us", flag: "🇺🇸")
        let canada = Countries(name: "Canada", slug: "canada", code: "ca", flag: "🇨🇦")
        
        countries.append(australia)
        countries.append(uk)
        countries.append(usa)
        countries.append(canada)
        
        return countries
    }
    
    static func defaultCountry() -> Countries {
        let usa = Countries(name: "United States", slug: "united-states-of-america", code: "us", flag: "🇺🇸")
        
        return usa
    }
}
