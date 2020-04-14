//
//  HomeViewController.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 5/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit
import Charts

class HomeViewController: UIViewController {

    var isWorldwideData: Bool = true
    var country: String = ""
    
    //Titles
    let locationTitle = CVDStatsLabel(alignment: .center, fontSize: 32)
    let chartTitle = CVDStatsLabel(alignment: .center, fontSize: 24)
    
    //Data Views
    var totalCases: CVDStatsView!
    var newCases: CVDStatsView!
    var totalDeaths: CVDStatsView!
    var newDeaths: CVDStatsView!
    var totalRecovered: CVDStatsView!
    var newRecovered: CVDStatsView!
    
    //Charts
    var chartView: BarChartView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "COVID-19 DATA"
        tabBarController?.tabBar.isTranslucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoadingView()
        NetworkManager.shared.getGlobalData { [ weak self ](total) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.refreshData(total: total)
                self.configureUI()
                self.configureLocationTitle()
                self.configureCases()
                self.configureDeaths()
                self.configureRecovered()
                self.configureChart()
            }
            self.dismissLoadingView()
        }
    }
    
    func refreshData(total: TotalsGlobal) {
        totalCases = CVDStatsView(text: "Total Cases", data: total.TotalConfirmed, textColor: .label, fontSize: 20)
        newCases = CVDStatsView(text: "New Cases", data: total.NewConfirmed, textColor: .label, fontSize: 20)
        
        totalDeaths = CVDStatsView(text: "Total Deaths", data: total.TotalDeaths, textColor: .systemRed, fontSize: 20)
        newDeaths = CVDStatsView(text: "New Deaths", data: total.NewDeaths, textColor: .systemRed, fontSize: 20)
        
        totalRecovered = CVDStatsView(text: "Total Recovered", data: total.TotalRecovered, textColor: .systemGreen, fontSize: 20)
        newRecovered = CVDStatsView(text: "New Recovered", data: total.NewRecovered, textColor: .systemGreen, fontSize: 20)
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    func configureLocationTitle() {
        view.addSubview(locationTitle)
        locationTitle.translatesAutoresizingMaskIntoConstraints = false
        locationTitle.text = isWorldwideData ? "World" : country
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            locationTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            locationTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding)
        ])
    }
    
    func configureCases() {
        view.addSubview(totalCases)
        view.addSubview(newCases)
        totalCases.translatesAutoresizingMaskIntoConstraints = false
        newCases.translatesAutoresizingMaskIntoConstraints = false
        
        let emptySpaceBetweenViewsSize: CGFloat = 20
        let numberOfEmptySpaces: CGFloat = 3
        let viewWidth = (view.bounds.width - (emptySpaceBetweenViewsSize * numberOfEmptySpaces)) / 2

        NSLayoutConstraint.activate([
            totalCases.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: emptySpaceBetweenViewsSize),
            totalCases.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: emptySpaceBetweenViewsSize),
            totalCases.widthAnchor.constraint(equalToConstant: viewWidth),
            totalCases.heightAnchor.constraint(equalToConstant: viewWidth / 2),
            
            newCases.topAnchor.constraint(equalTo: locationTitle.bottomAnchor, constant: emptySpaceBetweenViewsSize),
            newCases.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -emptySpaceBetweenViewsSize),
            newCases.widthAnchor.constraint(equalToConstant: viewWidth),
            newCases.heightAnchor.constraint(equalToConstant: viewWidth / 2)
        ])
    }
    
    func configureDeaths() {
        view.addSubview(totalDeaths)
        view.addSubview(newDeaths)
        totalDeaths.translatesAutoresizingMaskIntoConstraints = false
        newDeaths.translatesAutoresizingMaskIntoConstraints = false
        
        let emptySpaceBetweenViewsSize: CGFloat = 20
        let numberOfEmptySpaces: CGFloat = 3
        let viewWidth = (view.bounds.width - (emptySpaceBetweenViewsSize * numberOfEmptySpaces)) / 2

        NSLayoutConstraint.activate([
            totalDeaths.topAnchor.constraint(equalTo: totalCases.bottomAnchor, constant: emptySpaceBetweenViewsSize),
            totalDeaths.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: emptySpaceBetweenViewsSize),
            totalDeaths.widthAnchor.constraint(equalToConstant: viewWidth),
            totalDeaths.heightAnchor.constraint(equalToConstant: viewWidth / 2),
            
            newDeaths.topAnchor.constraint(equalTo: newCases.bottomAnchor, constant: emptySpaceBetweenViewsSize),
            newDeaths.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -emptySpaceBetweenViewsSize),
            newDeaths.widthAnchor.constraint(equalToConstant: viewWidth),
            newDeaths.heightAnchor.constraint(equalToConstant: viewWidth / 2)
        ])
    }
    
    func configureRecovered() {
        view.addSubview(totalRecovered)
        view.addSubview(newRecovered)
        totalRecovered.translatesAutoresizingMaskIntoConstraints = false
        newRecovered.translatesAutoresizingMaskIntoConstraints = false
        
        let emptySpaceBetweenViewsSize: CGFloat = 20
        let numberOfEmptySpaces: CGFloat = 3
        let viewWidth = (view.bounds.width - (emptySpaceBetweenViewsSize * numberOfEmptySpaces)) / 2

        NSLayoutConstraint.activate([
            totalRecovered.topAnchor.constraint(equalTo: totalDeaths.bottomAnchor, constant: emptySpaceBetweenViewsSize),
            totalRecovered.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: emptySpaceBetweenViewsSize),
            totalRecovered.widthAnchor.constraint(equalToConstant: viewWidth),
            totalRecovered.heightAnchor.constraint(equalToConstant: viewWidth / 2),
            
            newRecovered.topAnchor.constraint(equalTo: newDeaths.bottomAnchor, constant: emptySpaceBetweenViewsSize),
            newRecovered.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -emptySpaceBetweenViewsSize),
            newRecovered.widthAnchor.constraint(equalToConstant: viewWidth),
            newRecovered.heightAnchor.constraint(equalToConstant: viewWidth / 2)
        ])
    }

    func configureChart() {
        
        //Chart Title
        view.addSubview(chartTitle)
        chartTitle.text = "New cases - Last 5 days"
        
        NSLayoutConstraint.activate([
            chartTitle.topAnchor.constraint(equalTo: totalRecovered.bottomAnchor, constant: 20),
            chartTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        let days = ["20/04", "21/04", "22/04", "23/04", "24/04"]
        let cases = [123, 452, 12, 89, 1860]
        
        chartView = BarChartView()
        view.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.noDataText = "No data"
        chartView.isUserInteractionEnabled = false
        
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelCount = 5
        chartView.xAxis.labelPosition = .bottom
        
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false

        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<5 {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(cases[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "New cases last 5 days")
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: chartTitle.bottomAnchor, constant: padding),
            chartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            chartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            chartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            chartView.heightAnchor.constraint(equalToConstant: 250)
            
        ])
    }
}

