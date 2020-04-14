//
//  Int+Ext.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 8/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit

extension Int {
    func toStringWithThousandSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        let number = formatter.string(from: NSNumber(value: self)) ?? "#Error"
        
        return number
    }
}
