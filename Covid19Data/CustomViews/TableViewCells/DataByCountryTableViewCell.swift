//
//  DataByCountryTableViewCell.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 6/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit

class DataByCountryTableViewCell: UITableViewCell {

    static let reuseID = "dataByCountry"
    
    let positionLabel = CVDStatsLabel(alignment: .center, fontSize: 14)
    let countryLabel = CVDStatsLabel(alignment: .center, fontSize: 14)
    let totalNumbersLabel = CVDStatsLabel(alignment: .center, fontSize: 14)
    let newNumbersLabel = CVDStatsLabel(alignment: .center, fontSize: 14)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        totalNumbersLabel.translatesAutoresizingMaskIntoConstraints = false
        newNumbersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(positionLabel)
        addSubview(countryLabel)
        addSubview(totalNumbersLabel)
        addSubview(newNumbersLabel)
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            positionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            positionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            
            countryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            countryLabel.leadingAnchor.constraint(equalTo: positionLabel.trailingAnchor, constant: padding),
            
            newNumbersLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            newNumbersLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            newNumbersLabel.widthAnchor.constraint(equalToConstant: 70),
            
            totalNumbersLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            totalNumbersLabel.trailingAnchor.constraint(equalTo: newNumbersLabel.leadingAnchor, constant: -padding),
            totalNumbersLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}
