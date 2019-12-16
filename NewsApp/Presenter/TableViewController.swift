//
//  TableViewController.swift
//  NewsApp
//
//  Created by Victor Smirnov on 08.12.2019.
//  Copyright © 2019 Victor Smirnov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate {
  
  var dataSearchController: UISearchController!
  var filteredArticles: [Article] = []
  
  @IBAction func refreshControlAction(_ sender: Any) {
    
    NewsData.isReload = true
    NewsData.shared.loadNews {
      DispatchQueue.main.async {
        self.refreshControl?.endRefreshing()
        self.tableView.reloadData()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.estimatedRowHeight = 90
    tableView.rowHeight = UITableView.automaticDimension
    
    dataSearchController = UISearchController(searchResultsController: nil)
    dataSearchController.searchResultsUpdater = self
    dataSearchController.obscuresBackgroundDuringPresentation = false
    tableView.tableHeaderView = dataSearchController.searchBar
    
    NewsData.shared.loadNews {
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  //  MARK: - SearchController
  func updateSearchResults(for searchController: UISearchController) {
    
    if let searchText = dataSearchController.searchBar.text {
      filterContentForSearchText(searchText: searchText)
      tableView.reloadData()
    }
    
  }
  
  func filterContentForSearchText(searchText: String) {
    
    filteredArticles = NewsData.shared.articles.filter { (article) -> Bool in
      return article.title.localizedCaseInsensitiveContains(searchText) || article.content.localizedCaseInsensitiveContains(searchText)
    }
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return dataSearchController.isActive ? filteredArticles.count : NewsData.shared.articles.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
    let article = dataSearchController.isActive ? filteredArticles[indexPath.row] : NewsData.shared.articles[indexPath.row]
    
    DispatchQueue.main.async {
      if let imageURL = URL(string: article.urlToImage) {
        if let imageData = try? Data(contentsOf: imageURL) {
          cell.picView.image = UIImage(data: imageData)
        }
      }
    }
    
    cell.titleView.text = article.title
    cell.authorView.text = article.author
    cell.dateView.text = article.publishedAt
    
    return cell
  }
  
  // MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if segue.identifier == "articleDetail" {
      if let vc = segue.destination as? ViewController, let articleIndex = tableView.indexPathForSelectedRow?.row  {
        vc.article = dataSearchController.isActive ? filteredArticles[articleIndex] : NewsData.shared.articles[articleIndex]
      }
    }
  }
}
