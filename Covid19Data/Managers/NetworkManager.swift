//
//  NetworkManager.swift
//  Covid19Data
//
//  Created by Leonardo D'Amato on 5/4/20.
//  Copyright © 2020 Leonardo D'Amato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetworkManager {
    static let shared = NetworkManager()
    
    let cache = NSCache<NSString, UIImage>()
    
    func getCountriesData(completion: @escaping ([TotalsByCountry]) -> Void) {
        guard let url = URL(string: "https://api.covid19api.com/summary") else {
            return
        }
        
        Alamofire.request(url).responseJSON { (response) in
            if let value = response.result.value {
                let data = JSON(value)
                let countries = data["Countries"]
                
                var countriesData = [TotalsByCountry]()
                
                for c in countries.array! {
                    let total = TotalsByCountry(
                        Country: c["Country"].stringValue,
                        CountrySlug: c["Slug"].stringValue,
                        NewConfirmed: c["NewConfirmed"].intValue,
                        TotalConfirmed: c["TotalConfirmed"].intValue,
                        NewDeaths: c["NewDeaths"].intValue,
                        TotalDeaths: c["TotalDeaths"].intValue,
                        NewRecovered: c["NewRecovered"].intValue,
                        TotalRecovered: c["TotalRecovered"].intValue)
                    
                    countriesData.append(total)
                }
                
                completion(countriesData)
            }
        }
    }
    
    func getGlobalData(completion: @escaping (TotalsGlobal) -> Void) {
        guard let url = URL(string: "https://api.covid19api.com/summary") else {
            return
        }
        
        Alamofire.request(url).responseJSON { response in
            if let value = response.result.value {
                let data = JSON(value)
                let totals = TotalsGlobal(
                    NewConfirmed: data["Global"]["NewConfirmed"].intValue,
                    TotalConfirmed: data["Global"]["TotalConfirmed"].intValue,
                    NewDeaths: data["Global"]["NewDeaths"].intValue,
                    TotalDeaths: data["Global"]["TotalDeaths"].intValue,
                    NewRecovered: data["Global"]["NewRecovered"].intValue,
                    TotalRecovered: data["Global"]["TotalRecovered"].intValue)
                
                completion(totals)
            }
        }
    }
    
    func getLastFiveDaysCases(country: String, completion: @escaping([LastFiveDays]) -> Void) {
        let urlString = "https://api.covid19api.com/total/country/" + country + "/status/confirmed"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        Alamofire.request(url).responseJSON { (response) in
            if let value = response.result.value {
                let data = JSON(value)
                
                var array: [LastFiveDays] = []
                
                for item in data.array!.suffix(6) {
                    let i = LastFiveDays(date: item["Date"].stringValue.toStringFromISO8601(format: "dd/MM/yy"), cases: item["Cases"].intValue)
                    array.append(i)
                }
                
                var finalArray: [LastFiveDays] = []
                
                var counter = 0
                for _ in 0..<5 {
                    let cases = array[counter+1].cases - array[counter].cases
                    finalArray.append(LastFiveDays(date: array[counter+1].date, cases: cases < 0 ? 0 : cases))
                    counter += 1
                }
                completion(finalArray)
            }
        }
    }
    
    func getNews(country: Countries, completion: @escaping([News]) -> Void) {
        let baseUrl = "https://newsapi.org/v2/top-headlines?"
        let apiKey = "apiKey=c5eb9fef938046fcaf94d0b1feed6989"
        let keywordsParameter = "q=corona&q=covid"
        let countryParameter = "country=" + country.code
        
        let urlString = baseUrl + apiKey + "&" + keywordsParameter + "&" + countryParameter
        guard let url = URL(string: urlString) else {
            #warning("print error")
            return
        }
        
        var news = [News]()
        
        Alamofire.request(url).responseJSON { (response) in
            if let value = response.result.value {
                let data = JSON(value)
                
                for article in data["articles"].array! {
                    let item = News(sourceName: article["source"]["name"].stringValue,
                                    author: article["author"].stringValue,
                                    title: article["title"].stringValue,
                                    description: article["description"].stringValue,
                                    content: article["content"].stringValue,
                                    url: article["url"].stringValue,
                                    urlToImage: article["urlToImage"].stringValue,
                                    publishedAt: article["publishedAt"].stringValue)
                    
                    news.append(item)
                }
                
                completion(news)
            }
        }
    }
}
