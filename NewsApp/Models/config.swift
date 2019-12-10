//
//  config.swift
//  NewsApp
//
//  Created by Victor Smirnov on 07.12.2019.
//  Copyright © 2019 Victor Smirnov. All rights reserved.
//

import Foundation


let apiUrl: String = "https://newsapi.org/v2/"
let apiKey: String = "75c2bb76933b4995ba27d29c4404c1bf"

enum apiRoute: String {
  
  case everything = "everything"
  case topheadlines = "top-headlines"
  case sources = "sources"
  
}

enum countries: String {
  
  case Russia = "ru"
  case USA = "us"
  case Ukraine = "ua"
  case UK = "uk"

}
