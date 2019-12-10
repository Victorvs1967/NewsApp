//
//  Article.swift
//  NewsApp
//
//  Created by Victor Smirnov on 07.12.2019.
//  Copyright © 2019 Victor Smirnov. All rights reserved.
//

import Foundation

/*
 {
 "source": {
 "id": null,
 "name": "Lifehacker.com"
 },
 "author": "Lisa Rowan on Two Cents, shared by Lisa Rowan to Lifehacker",
 "title": "Invest in Crypto Stocks Instead of Actual Cryptocurrency",
 "description": "Just a few short years ago, buying up cryptocurrency was all the rage. In theory, you could spend a little on Bitcoin or one of the other popular cryptocurrencies, and cash out with an astonishing rate of return.",
 "url": "https://twocents.lifehacker.com/invest-in-crypto-stocks-instead-of-actual-cryptocurrenc-1840264223",
 "urlToImage": "https://i.kinja-img.com/gawker-media/image/upload/c_fill,f_auto,fl_progressive,g_center,h_675,pg_1,q_80,w_1200/valka9d65wlgqgm18cis.jpg",
 "publishedAt": "2019-12-06T16:00:00Z",
 "content": "Just a few short years ago, buying up cryptocurrency was all the rage. In theory, you could spend a little on Bitcoin or one of the other popular cryptocurrencies, and cash out with an astonishing rate of return. \r\nBut as you might have noticed, Bitcoin and s… [+3033 chars]"
 }
 */

struct Article {
  
  var author: String
  var title: String
  var description: String
  var url: String
  var urlToImage: String
  var publishedAt: String
  var content: String
  var sourceName: String
  
  init(dictionary: Dictionary<String, Any>) {

    author = dictionary["author"] as? String ?? ""
    title = dictionary["title"] as? String ?? ""
    publishedAt = dictionary["publishedAt"] as? String ?? ""
    description = dictionary["description"] as? String ?? ""
    url = dictionary["url"] as? String ?? ""
    urlToImage = dictionary["urlToImage"] as? String ?? ""
    sourceName = (dictionary["source"] as? Dictionary<String, Any> ?? ["": ""])["name"] as? String ?? ""
    content = dictionary["content"] as? String ?? ""

  }
  
}
