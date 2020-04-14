//
//  StatsView.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 5/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit

class CVDStatsView: UIView {

    var text = ""
    var data = 0
    
    var textColor = UIColor()
    
    let titleLabel = CVDStatsLabel(alignment: .center, fontSize: 20)
    let dataLabel = CVDStatsLabel(alignment: .center, fontSize: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String, data: Int, textColor: UIColor, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.text = text
        self.data = data
        self.textColor = textColor

        configure()
    }
    
    func configure() {
        addSubview(titleLabel)
        addSubview(dataLabel)
        
        backgroundColor = .quaternarySystemFill
        layer.cornerRadius = 7
        
        titleLabel.textColor = textColor
        dataLabel.textColor = textColor
        
        titleLabel.text = text
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        let number = formatter.string(from: NSNumber(value: data))
        dataLabel.text = number
                
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            
            dataLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 20),
            dataLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            dataLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        ])
    }

}
