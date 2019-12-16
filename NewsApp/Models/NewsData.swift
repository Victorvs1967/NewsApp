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
  
  static var isReload = false
  
  var urlToData: URL {
    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0] + "/data.json"
    let urlPath = URL(fileURLWithPath: path)
    return urlPath
  }
    
  var articles: [Article] {
    
    var array: [Article] = []
    
    do {
      
      let path = urlToData
      let data = try Data(contentsOf: path)
      let rootDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
      
      if let articlesArray = rootDictionary["articles"] as? [Dictionary<String, Any>] {
        for dictionary in articlesArray {
          array.append(Article(dictionary: dictionary))
        }
      }
    } catch {
      print(error.localizedDescription)
    }
    return array
  }
  
  func loadNews(completionHandler: (() -> Void)?) {
    
    let urlString = "\(apiUrl)\(apiRoute.topheadlines.rawValue)?country=\(countries.USA.rawValue)&apiKey=\(apiKey)"
    guard let url = URL(string: urlString) else { return }
    
    URLSession(configuration: .default).downloadTask(with: url) { urlFile, response, error in
      
      do {
        
        let path = self.urlToData
        
        switch NewsData.isReload {
        case true:
          let newPath = try FileManager.default.replaceItemAt(path, withItemAt: urlFile!)
          print(newPath!)
        default:
          try FileManager.default.copyItem(at: urlFile!, to: path)
        }
      } catch {
        print("File already exist!")
      }
      
      NewsData.isReload = false
      completionHandler?()
      
    }.resume()
  }
  
}
