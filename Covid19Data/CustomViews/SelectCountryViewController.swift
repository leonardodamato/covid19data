//
//  SelectCountryViewController.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 10/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit

protocol GetSelectedCountryDelegate {
    func getCountry(country: Countries)
}

class SelectCountryViewController: UIViewController {
    
    var delegate: GetSelectedCountryDelegate?
    
    var countries: [Countries] = []
    var selectedCountry: String = ""
    
    var containerView = UIView()
    var countriesTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        countries = Countries.configureCountries()
    }
    
    private func configureUI() {
        containerView.backgroundColor = .black
        containerView.alpha = 0.7
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        countriesTableView.layer.cornerRadius = 15
        countriesTableView.layer.borderWidth = 2
        countriesTableView.layer.borderColor = UIColor.systemTeal.cgColor
        countriesTableView.separatorStyle = .none
        
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
        countriesTableView.register(BasicTableViewCell.self, forCellReuseIdentifier: BasicTableViewCell.reuseID)
        countriesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(countriesTableView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            countriesTableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 200),
            countriesTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50),
            countriesTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -50),
            countriesTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -200)
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        
        if touch?.view == containerView {
            dismiss(animated: true)
        }
    }
}

extension SelectCountryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BasicTableViewCell.reuseID, for: indexPath) as! BasicTableViewCell
        
        cell.titleLabel.text = countries[indexPath.row].flag + " " + countries[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getCountry(country: countries[indexPath.row] )
    }
}
