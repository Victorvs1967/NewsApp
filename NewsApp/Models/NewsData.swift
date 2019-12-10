//
//  NewsData.swift
//  NewsApp
//
//  Created by Victor Smirnov on 07.12.2019.
//  Copyright © 2019 Victor Smirnov. All rights reserved.
//

import Foundation

class NewsData {
  
  static let shared = NewsData()
  
  var articles: [Article] {
    
    var array: [Article] = []
    do {
      let data = try Data(contentsOf: urlToData)
      let rootDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
      let articlesArray = (rootDictionary["articles"] as! [Dictionary<String, Any>])
      
      for dictionary in articlesArray {
        array.append(Article(dictionary: dictionary))
      }
    } catch {
      print(error.localizedDescription)
    }
    return array
  }
  
  var urlToData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json"
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
  }
  
  func loadNews(completionHandler: (() -> Void)?) {
    
    let urlString = "\(apiUrl)\(apiRoute.topheadlines)?country=\(countries.Russia)&apiKey=\(apiKey)"
    guard let url = URL(string: urlString) else { return }
    
    URLSession(configuration: .default).downloadTask(with: url) { urlFile, response, error in
      
      if let dataUrl = urlFile {
        try? FileManager.default.copyItem(at: dataUrl, to: self.urlToData)
      }
      
      completionHandler?()
      
    }.resume()
  }
  
}
