//
//  String+Ext.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 8/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import Foundation

extension String {
    func toStringFromISO8601(format: String) -> String {
        var result = ""
        
        let formatter = ISO8601DateFormatter()
        guard let dateValue = formatter.date(from: self) else {
            result = "Unknown date and time"
            return result
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        result = dateFormatter.string(from: dateValue)
        
        return result
    }
}
