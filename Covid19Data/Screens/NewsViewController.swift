//
//  NewsViewController.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 5/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    var article: News!
    
    var newsTitleLabel: UILabel!
    var newsDescriptionLabel: UILabel!
    var authorDateAndSourceLabel: UILabel!
    var imageView: UIImageView!
    var contentLabel: UILabel!
    var viewFullStory: UIButton!
    
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationController()
        configureView()
        configureArticle()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
        
        scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        
        newsTitleLabel = UILabel()
        newsTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        newsTitleLabel.textColor = .label
        newsTitleLabel.numberOfLines = 0
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(newsTitleLabel)
        
        newsDescriptionLabel = UILabel()
        newsDescriptionLabel.font = UIFont.systemFont(ofSize: 18)
        newsDescriptionLabel.textColor = .secondaryLabel
        newsDescriptionLabel.numberOfLines = 0
        newsDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(newsDescriptionLabel)

        authorDateAndSourceLabel = UILabel()
        authorDateAndSourceLabel.font = UIFont.systemFont(ofSize: 14)
        authorDateAndSourceLabel.textColor = .tertiaryLabel
        authorDateAndSourceLabel.numberOfLines = 1
        authorDateAndSourceLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(authorDateAndSourceLabel)

        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)

        contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.textColor = .label
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentLabel)

        viewFullStory = UIButton()
        viewFullStory.setTitle("View Full Story", for: .normal)
        viewFullStory.backgroundColor = .systemTeal
        viewFullStory.titleLabel?.textColor = .white
        viewFullStory.layer.cornerRadius = 10
        viewFullStory.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(viewFullStory)
        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            newsTitleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            newsTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            newsTitleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            
            newsDescriptionLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 10),
            newsDescriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            newsDescriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),

            authorDateAndSourceLabel.topAnchor.constraint(equalTo: newsDescriptionLabel.bottomAnchor, constant: 10),
            authorDateAndSourceLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            authorDateAndSourceLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),

            imageView.topAnchor.constraint(equalTo: authorDateAndSourceLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            contentLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            contentLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            contentLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),

            viewFullStory.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: padding),
            viewFullStory.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            viewFullStory.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
            viewFullStory.heightAnchor.constraint(equalToConstant: 44),
            viewFullStory.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding)
        ])
    }
    
    func configureNavigationController() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func configureArticle() {
        
        showLoadingView()
        let date = article.publishedAt.toStringFromISO8601(format: "dd MMMM yyyy | hh:mm")
        
        viewFullStory.addTarget(self, action: #selector(goToArticle), for: .touchUpInside)
        
        newsTitleLabel.text = article.title
        newsDescriptionLabel.text = article.description
        authorDateAndSourceLabel.text = String(format: "%@ on %@", article.author, date)
        imageView.downloadImage(imageUrl: article.urlToImage)
        contentLabel.text = article.content
        dismissLoadingView()
    }
    
    @objc func goToArticle() {
        guard let url = URL(string: article.url) else {
            self.showErrorAlert(title: "Error", message: "Invalid URL. Please try again.")
            return
        }
        
        UIApplication.shared.open(url)
    }
}

extension NewsViewController : UIScrollViewDelegate {
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }
}
