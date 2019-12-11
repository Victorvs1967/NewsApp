//
//  PageViewController.swift
//  NewsApp
//
//  Created by Victor Smirnov on 08.12.2019.
//  Copyright © 2019 Victor Smirnov. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
  
  @IBAction func refreshButton(_ sender: Any) {
    
    NewsData.isReload = true
    NewsData.shared.loadNews {
      self.showViewController()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.dataSource = self
    
    self.showViewController()
    
    NewsData.shared.loadNews {
      self.showViewController()
    }
  }
  
  func showViewController() {
    
    DispatchQueue.main.async {
      if let pvc = self.pageViewController(for: 0) {
        self.setViewControllers([pvc], direction: .forward, animated: false, completion: nil)
      }
    }
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    
    let vc = viewController as? ViewController
    let index = (vc?.index ?? 0) - 1
    return self.pageViewController(for: index)
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    
    let vc = viewController as? ViewController
    let index = (vc?.index ?? 0) + 1
    return self.pageViewController(for: index)
  }
  
  func pageViewController(for index: Int) -> ViewController? {
    
    if let vc = storyboard?.instantiateViewController(withIdentifier: "viewControllerId") as? ViewController {
      
      let pageIndex = (index < 0 || index >= NewsData.shared.articles.count) ? 0 : index
      vc.article = NewsData.shared.articles[pageIndex]
      vc.index = pageIndex
      return vc
    }
    return nil
  }
  
}

