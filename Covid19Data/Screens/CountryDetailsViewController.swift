//
//  CountryDetailsViewController.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 5/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController {

    
    
    var selectedCountry: TotalsByCountry?
    
    var chartData: [LastFiveDays] = []
    
    var locationTitle = CVDStatsLabel(alignment: .left, fontSize: 28)
    
    var scrollView: UIScrollView!
    
    var casesView: UIView!
    var deathsView: UIView!
    var recoveredView: UIView!
    var chartView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let _ = selectedCountry else {
            #warning("ALERT ERROR HERE")
            return
        }
        showLoadingView()
        configureLocationTitle()
        getData()
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Country Stats"
        tabBarController?.tabBar.isTranslucent = false
    }
    
    func configureLocationTitle() {
        view.addSubview(locationTitle)
        locationTitle.translatesAutoresizingMaskIntoConstraints = false
        locationTitle.text = selectedCountry!.Country
        
        NSLayoutConstraint.activate([
            locationTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            locationTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
    }
    
    func configureViews() {
           scrollView = UIScrollView()
           view.addSubview(scrollView)
           scrollView.translatesAutoresizingMaskIntoConstraints = false
           
           casesView = UIView()
           casesView.translatesAutoresizingMaskIntoConstraints = false
           scrollView.addSubview(casesView)
           
           deathsView = UIView()
           deathsView.translatesAutoresizingMaskIntoConstraints = false
           scrollView.addSubview(deathsView)
           
           recoveredView = UIView()
           recoveredView.translatesAutoresizingMaskIntoConstraints = false
           scrollView.addSubview(recoveredView)
           
           chartView = UIView()
           chartView.translatesAutoresizingMaskIntoConstraints = false
           scrollView.addSubview(chartView)
        
        
        NetworkManager.shared.getLastFiveDaysCases(country: selectedCountry!.CountrySlug) { (data) in
                self.chartData = data
                let days = self.chartData.map { $0.date}
                let cases = self.chartData.map { $0.cases}
                self.add(childViewController: LineChartViewController(labelsArray: days, dataArray: cases), to: self.chartView)
            }
           
           NSLayoutConstraint.activate([
               scrollView.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: 10),
               scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
               scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
               scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
               
               casesView.topAnchor.constraint(equalTo: scrollView.topAnchor),
               casesView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
               casesView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
               casesView.heightAnchor.constraint(equalToConstant: 110),
               
               deathsView.topAnchor.constraint(equalTo: casesView.bottomAnchor, constant: 10),
               deathsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
               deathsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
               deathsView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
               deathsView.heightAnchor.constraint(equalToConstant: 110),
               
               recoveredView.topAnchor.constraint(equalTo: deathsView.bottomAnchor, constant: 10),
               recoveredView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
               recoveredView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
               recoveredView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
               recoveredView.heightAnchor.constraint(equalToConstant: 110),
               
               chartView.topAnchor.constraint(equalTo: recoveredView.bottomAnchor, constant: 10),
               chartView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
               chartView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
               chartView.heightAnchor.constraint(equalToConstant: 300),
               chartView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
           ])
       }
    
    func getData() {
        NetworkManager.shared.getGlobalData { [ weak self ](total) in
            guard let self = self else { return }
            DispatchQueue.main.async {
            self.configureViews()
            
            let cases = Statistics(title: "Confirmed Cases", totalData: self.selectedCountry!.TotalConfirmed, newData: self.selectedCountry!.NewConfirmed)
            let deaths = Statistics(title: "Deaths", totalData: self.selectedCountry!.TotalDeaths, newData: self.selectedCountry!.NewDeaths)
            let recovered = Statistics(title: "Recovered", totalData: self.selectedCountry!.TotalRecovered, newData: self.selectedCountry!.NewRecovered)
            
            
                self.add(childViewController: StatisticsViewController(statistic: cases, totalNumber: cases.totalData, newNumber: cases.newData), to: self.casesView)
                
                self.add(childViewController: StatisticsViewController(statistic: deaths, totalNumber: deaths.totalData, newNumber: deaths.newData), to: self.deathsView)
                
                self.add(childViewController: StatisticsViewController(statistic: recovered, totalNumber: recovered.totalData, newNumber: recovered.newData), to: self.recoveredView)
            }
            self.dismissLoadingView()
        }
    }
    
    func add(childViewController: UIViewController, to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
}
