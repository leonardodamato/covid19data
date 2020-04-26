//
//  CountriesViewController.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 5/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {

    var segmentedControl: UISegmentedControl!
    var dataTableView: UITableView!
    var tableViewContainer: UIView!
    
    var countries = [TotalsByCountry]()
    var filteredCountries = [TotalsByCountry]()
    var selectedCountry: TotalsByCountry?
    var isSearching = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSearchController()
        title = "Countries"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoadingView()
        NetworkManager.shared.getCountriesData { [ weak self ] (countriesData) in
            guard let self = self else { return }
            self.countries = countriesData
            self.updateView()
            self.dismissLoadingView()
        }
    }
    
    func updateView() {
        configureUI()
        configureSegmentedControl()
        configureTableViewContainer()
        configureTableView()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    func configureSegmentedControl() {
        
        let items = ["Cases", "Deaths", "Recovered"]
        segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(segmentedControlDidChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        segmentedControl.selectedSegmentIndex = 0
        
        //UI
        segmentedControl.tintColor = .systemTeal
        segmentedControl.layer.borderColor = UIColor.systemTeal.cgColor
        segmentedControl.layer.borderWidth = 1
        segmentedControl.backgroundColor = .systemBackground
        segmentedControl.selectedSegmentTintColor = .systemTeal
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func segmentedControlDidChanged() {
        dataTableView.reloadData()
    }
}

//MARK: - TableViewSection
extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableViewContainer() {
        tableViewContainer = UIView()
        view.addSubview(tableViewContainer)
        tableViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            tableViewContainer.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: padding),
            tableViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureTableView() {
        dataTableView = UITableView(frame: tableViewContainer.bounds)
        dataTableView.translatesAutoresizingMaskIntoConstraints = false
        tableViewContainer.addSubview(dataTableView)
        dataTableView.register(DataByCountryTableViewCell.self, forCellReuseIdentifier: DataByCountryTableViewCell.reuseID)
        dataTableView.register(DataByCountryHeaderTableViewCell.self, forCellReuseIdentifier: DataByCountryHeaderTableViewCell.reuseID)
        dataTableView.delegate = self
        dataTableView.dataSource = self
        
        NSLayoutConstraint.activate([
            dataTableView.topAnchor.constraint(equalTo: tableViewContainer.topAnchor),
            dataTableView.leadingAnchor.constraint(equalTo: tableViewContainer.leadingAnchor),
            dataTableView.trailingAnchor.constraint(equalTo: tableViewContainer.trailingAnchor),
            dataTableView.bottomAnchor.constraint(equalTo: tableViewContainer.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredCountries.count : countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataByCountryTableViewCell.reuseID, for: indexPath) as! DataByCountryTableViewCell
        
        let positionText = indexPath.row + 1
        
        let activeArray = isSearching ? filteredCountries : countries
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let confirmedArray = activeArray.sorted(by: { $0.TotalConfirmed > $1.TotalConfirmed })
            
            cell.positionLabel.text = String(positionText)
            cell.countryLabel.text = confirmedArray[indexPath.row].Country
            cell.totalNumbersLabel.text = confirmedArray[indexPath.row].TotalConfirmed.toStringWithThousandSeparator()
            cell.newNumbersLabel.text = confirmedArray[indexPath.row].NewConfirmed.toStringWithThousandSeparator()
        case 1:
            let deathsArray = activeArray.sorted(by: { $0.TotalDeaths > $1.TotalDeaths })
            
            cell.positionLabel.text = String(positionText)
            cell.countryLabel.text = deathsArray[indexPath.row].Country
            cell.totalNumbersLabel.text = deathsArray[indexPath.row].TotalDeaths.toStringWithThousandSeparator()
            cell.newNumbersLabel.text = deathsArray[indexPath.row].NewDeaths.toStringWithThousandSeparator()
        case 2:
            let recoveredArray = activeArray.sorted(by: { $0.TotalRecovered > $1.TotalRecovered })
            
            cell.positionLabel.text = String(positionText)
            cell.countryLabel.text = recoveredArray[indexPath.row].Country
            cell.totalNumbersLabel.text = recoveredArray[indexPath.row].TotalRecovered.toStringWithThousandSeparator()
            cell.newNumbersLabel.text = recoveredArray[indexPath.row].NewRecovered.toStringWithThousandSeparator()
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: DataByCountryHeaderTableViewCell.reuseID) as! DataByCountryHeaderTableViewCell
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let activeArray = isSearching ? filteredCountries : countries
        var sortedArray: [TotalsByCountry] = []
        
        //Sort Array
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            sortedArray = activeArray.sorted(by: { $0.TotalConfirmed > $1.TotalConfirmed })
        case 1:
            sortedArray = activeArray.sorted(by: { $0.TotalDeaths > $1.TotalDeaths })
        case 2:
            sortedArray = activeArray.sorted(by: { $0.TotalRecovered > $1.TotalRecovered })
        default:
            break
        }
                
        let vc = CountryDetailsViewController()
        vc.selectedCountry = sortedArray[indexPath.row]
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
}

//MARK: - SearchController Section
extension CountriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isSearching = false
            dataTableView.reloadData()
            return
        }
        
        filteredCountries = countries.filter { $0.Country.lowercased().contains(filter.lowercased()) }
        isSearching = true
        dataTableView.reloadData()
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search country"
        searchController.searchBar.tintColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}
