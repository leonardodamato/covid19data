//
//  NewsTableViewCell.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 5/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let reuseID = "newsCell"
    
    var newsImage = UIImageView(frame: .zero)
    let title = CVDStatsLabel(alignment: .left, fontSize: 16)
    let date = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(news: News) {
        title.text = news.title
        newsImage.downloadImage(imageUrl: news.urlToImage)
        date.text = news.publishedAt.toStringFromISO8601(format: "dd MMMM yyyy | hh:mm")
    }
    
    private func configure() {
        addSubview(newsImage)
        addSubview(title)
        addSubview(date)
        
        //Configure image view
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        newsImage.clipsToBounds = true
        newsImage.layer.cornerRadius = 5
        newsImage.contentMode = .scaleAspectFill
        
        //Configure title label
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        
        //Configure date label
        date.font = UIFont.systemFont(ofSize: 14)
        date.textColor = .secondaryLabel
        date.translatesAutoresizingMaskIntoConstraints  = false

        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            newsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            newsImage.trailingAnchor.constraint(equalTo: title.leadingAnchor, constant: -padding),
            newsImage.widthAnchor.constraint(equalToConstant: 120),
            newsImage.heightAnchor.constraint(equalToConstant: 80),
            newsImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            title.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: padding),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            title.bottomAnchor.constraint(equalTo: date.topAnchor, constant: -padding),
            
            date.topAnchor.constraint(equalTo: title.bottomAnchor, constant: padding),
            date.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: padding),
            date.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            date.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        ])
    }
}
