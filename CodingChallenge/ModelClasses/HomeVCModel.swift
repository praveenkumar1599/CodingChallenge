//
//  HomeVCModel.swift
//  CodingChallenge
//
//  Created by Praveen on 3/20/20.

import Foundation

class HomeVCModel {
    var appleRSSFeed:AppleRSSFeed?
    var baseURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json"
    var dataArray:[Result] = []

    func getDataFromAPI(complete:@escaping (Bool) -> Void) {
        guard let gitUrl = URL(string: baseURL) else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                self.appleRSSFeed = try decoder.decode(AppleRSSFeed.self, from: data)
                if let data = self.appleRSSFeed?.feed?.results {
                    self.dataArray = data
                    complete(true)
                }
            } catch let err {
                complete(false)
                print("Error", err)
            }
        }.resume()
    }
}
