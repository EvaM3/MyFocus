//
//  MonthlySummaryCell.swift
//  MyFocus
//
//  Created by Eva Madarasz on 06/08/2022.
//

import UIKit



class SummaryCell: UITableViewCell {
 
  
    
    @IBOutlet weak var title: UILabel!
    
    
    func configureCell(item: ListElement) {
        title.textAlignment = .center
        title.text = item.title
    }
}

