//
//  TableViewCell.swift
//  NewsApp
//
//  Created by Victor Smirnov on 09.12.2019.
//  Copyright © 2019 Victor Smirnov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

  @IBOutlet weak var picView: UIImageView!
  @IBOutlet weak var titleView: UILabel!
  @IBOutlet weak var authorView: UILabel!
  @IBOutlet weak var dateView: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
  }
}
