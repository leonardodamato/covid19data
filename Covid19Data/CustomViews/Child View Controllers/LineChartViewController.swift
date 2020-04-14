//
//  LineChartViewController.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 12/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit
import Charts

class LineChartViewController: UIViewController {

    var chartTitle: CVDStatsLabel!
    var chartView: BarChartView!
    
    var labelsArray: [String] = []
    var dataArray: [Int] = []
    
    init(labelsArray: [String], dataArray: [Int]) {
        super.init(nibName: nil, bundle: nil)
        self.labelsArray = labelsArray
        self.dataArray = dataArray
        configureChart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func configureChart() {
        //Chart Title
        chartTitle = CVDStatsLabel(alignment: .left, fontSize: 22)
        view.addSubview(chartTitle)
        chartTitle.text = "New cases - Last 5 days"
        
        NSLayoutConstraint.activate([
            chartTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            chartTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
//        labelsArray = ["20/04", "21/04", "22/04", "23/04", "24/04"]
//        dataArray = [123, 452, 12, 89, 1860]
        
        chartView = BarChartView()
        view.addSubview(chartView)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.noDataText = "No data"
        chartView.isUserInteractionEnabled = false
        
        chartView.legend.textColor = .label
        chartView.data?.setValueTextColor(.label)
        chartView.tintColor = .systemTeal
        
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: labelsArray)
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelCount = 5
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelTextColor = .label
        
        chartView.leftAxis.drawAxisLineEnabled = false
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        
        chartView.rightAxis.drawAxisLineEnabled = false
        chartView.rightAxis.drawLabelsEnabled = false
        chartView.rightAxis.drawGridLinesEnabled = false

        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<5 {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(dataArray[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "New cases last 5 days")
        chartDataSet.valueColors = [UIColor.label]
        chartDataSet.colors = [UIColor.systemTeal]
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: chartTitle.bottomAnchor, constant: padding),
            chartView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chartView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            chartView.heightAnchor.constraint(equalToConstant: 250)
            
        ])
    }
}
