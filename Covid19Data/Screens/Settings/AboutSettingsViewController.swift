//
//  AboutSettingsViewController.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 13/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit

class AboutSettingsViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        configureUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func configureUI() {
        navigationItem.title = "About"
        view.backgroundColor = .secondarySystemBackground
        
        let firstParagraph = "COVID19 Data is an independent application created by Leonardo D'Amato. For contact, please send an email to leonardodamato@outlook.com.\n\n All stats are fetched from https://covid19api.com/. \n\n All articles on News section are fetched from https://newsapi.org/."
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.text = firstParagraph
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
            //label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
    }
}
