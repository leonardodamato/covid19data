//
//  DataByCountryHeaderTableViewCell.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 7/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit

class DataByCountryHeaderTableViewCell: UITableViewCell {

    static let reuseID = "dataByCountryHeader"
    
    var totalLabel: UILabel!
    var newLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        backgroundColor = .systemTeal
        
        totalLabel = UILabel()
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.text = "Total"
        totalLabel.textColor = .white
        totalLabel.textAlignment = .center
        addSubview(totalLabel)
        
        newLabel = UILabel()
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        newLabel.text = "New"
        newLabel.textColor = .white
        newLabel.textAlignment = .center
        addSubview(newLabel)
        
        NSLayoutConstraint.activate([
            newLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            newLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            newLabel.widthAnchor.constraint(equalToConstant: 70),
            
            totalLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            totalLabel.trailingAnchor.constraint(equalTo: newLabel.leadingAnchor, constant: -10),
            totalLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}
