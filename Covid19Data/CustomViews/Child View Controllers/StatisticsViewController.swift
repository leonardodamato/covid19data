//
//  StatisticsViewController.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 10/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    var statistic: Statistics!
    
    var containerView: UIView!
    var statisticTitle: CVDStatsLabel!
    var total: CVDStatsLabel!
    var new: CVDStatsLabel!
    
    var totalBar = UIView()
    var newBar = UIView()
    
    //Numbers to create progressbar
    var totalNumber: Int = 0
    var newNumber: Int = 0

    
    let padding: CGFloat = 10
    
    init(statistic: Statistics, totalNumber: Int, newNumber: Int) {
        super.init(nibName: nil, bundle: nil)
        self.statistic = statistic
        self.totalNumber = totalNumber
        self.newNumber = newNumber
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainerView()
        configureTitle(title: statistic.title)
        configureTotal(totalData: statistic.totalData)
        configureNew(newData: statistic.newData)
        configureProgressBar(totalNumber: totalNumber, newNumber: newNumber)
    }
    
    private func configureContainerView() {
        containerView = UIView(frame: view.bounds)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .secondarySystemBackground
        containerView.layer.cornerRadius = 10
        view.addSubview(containerView)
                
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding / 2),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            containerView.widthAnchor.constraint(equalToConstant: view.bounds.width - (padding * 2)),
            containerView.heightAnchor.constraint(lessThanOrEqualToConstant: 110)
        ])
    }
    
    private func configureTitle(title: String) {
        statisticTitle = CVDStatsLabel(alignment: .left, fontSize: 26)
        statisticTitle.translatesAutoresizingMaskIntoConstraints = false
        statisticTitle.textColor = .label
        statisticTitle.text = title
        containerView.addSubview(statisticTitle)
        
        NSLayoutConstraint.activate([
            statisticTitle.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            statisticTitle.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
            statisticTitle.widthAnchor.constraint(equalTo: containerView.widthAnchor)
        ])
    }
    
    private func configureTotal(totalData: Int) {
        total = CVDStatsLabel(alignment: .left, fontSize: 20)
        total.translatesAutoresizingMaskIntoConstraints = false
        total.textColor = .systemTeal
        total.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        total.text = "Total: " + totalData.toStringWithThousandSeparator()
        containerView.addSubview(total)
        
        NSLayoutConstraint.activate([
            total.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
        ])
    }
    
    private func configureNew(newData: Int) {
        new = CVDStatsLabel(alignment: .left, fontSize: 22)
        new.translatesAutoresizingMaskIntoConstraints = false
        new.textColor = .systemOrange
        new.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        new.text = "New: " + newData.toStringWithThousandSeparator()
        containerView.addSubview(new)
        
        NSLayoutConstraint.activate([
            new.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
        ])
    }
    
    private func configureProgressBar(totalNumber: Int, newNumber: Int) {
        
        let containerWidth = containerView.bounds.width - (padding * 4)
        let newPercent = (newNumber * 100) / totalNumber
        let newWidth = (containerWidth * CGFloat(newPercent)) / 100
        let totalWidth = containerWidth - newWidth
        
        //Total
        view.addSubview(totalBar)
        
        totalBar.translatesAutoresizingMaskIntoConstraints = false
        totalBar.backgroundColor = .systemTeal
        
        NSLayoutConstraint.activate([
            totalBar.topAnchor.constraint(equalTo: new.bottomAnchor, constant: padding),
            totalBar.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            totalBar.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            totalBar.widthAnchor.constraint(equalToConstant: totalWidth),
            totalBar.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        //New
        view.addSubview(newBar)
        
        newBar.translatesAutoresizingMaskIntoConstraints = false
        newBar.backgroundColor = .systemOrange
        
        NSLayoutConstraint.activate([
            newBar.topAnchor.constraint(equalTo: total.bottomAnchor, constant: padding),
            newBar.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            newBar.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            newBar.widthAnchor.constraint(equalToConstant: newWidth),
            newBar.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

}
