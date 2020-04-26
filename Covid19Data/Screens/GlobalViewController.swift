//
//  GlobalViewController.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 10/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit

class GlobalViewController: UIViewController, UIScrollViewDelegate{

    var locationTitle = CVDStatsLabel(alignment: .left, fontSize: 28)
    
    var scrollView: UIScrollView!

    var casesView: UIView!
    var deathsView: UIView!
    var recoveredView: UIView!
    var chartView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "COVID19 Data"
        tabBarController?.tabBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingView()
        configureLocationTitle()
        getData()
    }
    
    func configureViews() {
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        
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
    
    func configureScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureLocationTitle() {
        view.addSubview(locationTitle)
        locationTitle.translatesAutoresizingMaskIntoConstraints = false
        locationTitle.text = "🌍 Global"
        
        NSLayoutConstraint.activate([
            locationTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            locationTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
        ])
    }
    
    func getData() {
        NetworkManager.shared.getGlobalData { [ weak self ](total) in
            guard let self = self else { return }
            
            let cases = Statistics(title: "Confirmed Cases", totalData: total.TotalConfirmed, newData: total.NewConfirmed)
            let deaths = Statistics(title: "Deaths", totalData: total.TotalDeaths, newData: total.NewDeaths)
            let recovered = Statistics(title: "Recovered", totalData: total.TotalRecovered, newData: total.NewRecovered)
            
            DispatchQueue.main.async {
                self.configureViews()
                
                self.add(childViewController: StatisticsViewController(statistic: cases, totalNumber: cases.totalData, newNumber: cases.newData), to: self.casesView)
                
                self.add(childViewController: StatisticsViewController(statistic: deaths, totalNumber: deaths.totalData, newNumber: deaths.newData), to: self.deathsView)
                
                self.add(childViewController: StatisticsViewController(statistic: recovered, totalNumber: recovered.totalData, newNumber: recovered.newData), to: self.recoveredView)
                
                //TODO: Global chart will be configured when API updates their data with the correct information. 
                //let days = ["20/04", "21/04", "22/04", "23/04", "24/04"]
                //let cases = [123, 452, 12, 89, 1860]
                //self.add(childViewController: LineChartViewController(labelsArray: days, dataArray: cases), to: self.chartView)
                
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
