//
//  NewsListViewController.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 7/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit



class NewsListViewController: UIViewController {
    
    var newsTableView: UITableView!    
    var newsArray: [News] = []
    
    var selectedCountry: Countries?
    var defaultCountry: Countries = Countries.defaultCountry()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Top Headlines"
        tabBarController?.tabBar.isTranslucent = false
        
        configureNavButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNews(for: selectedCountry ?? Countries.defaultCountry())
    }
    
    func getNews(for country: Countries) {
        showLoadingView()
        NetworkManager.shared.getNews(country: country) { [weak self] news in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.newsArray = news
                self.configureNewsTableView()
            }
            self.dismissLoadingView()
        }
    }
    
    func configureNewsTableView() {
        newsTableView = UITableView(frame: view.bounds)
        view.addSubview(newsTableView)
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseID)
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        newsTableView.separatorStyle = .none
        
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.reloadData()
        
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configureNavButton() {
        let country = selectedCountry ?? defaultCountry
        
        let button = UIBarButtonItem(title: country.flag, style: .plain, target: self, action: #selector(selectCountryView))

        navigationItem.rightBarButtonItem = button
    }
    
    @objc func selectCountryView() {
        let vc = SelectCountryViewController()
        vc.delegate = self
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
}

extension NewsListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath) as! NewsTableViewCell
        cell.set(news: newsArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = NewsViewController()
        let destNav = UINavigationController(rootViewController: destination)
        destination.article = newsArray[indexPath.row]
        present(destNav, animated: true)
    }
}

extension NewsListViewController: GetSelectedCountryDelegate {
    func getCountry(country: Countries) {
        self.dismiss(animated: true) {
            self.selectedCountry = country
            self.getNews(for: country)
            self.configureNavButton()
        }
    }
    
    
}
