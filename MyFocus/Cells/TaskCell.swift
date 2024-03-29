//
//  TaskCell.swift
//  MyFocus
//
//  Created by Eva Madarasz on 23/07/2022.
//

import UIKit



class TaskCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    
    @IBOutlet weak var checkMark: UIImageView!
    
    var listElement = ListElement.self
    
  
    func configureCheckMarkedCell(item: ListElement) {
        title.textAlignment = .left
        title.text = item.title
        
        if item.isCompleted {
            checkMark.image =  UIImage(systemName: "checkmark.rectangle.fill")!.withTintColor(.systemMint, renderingMode: .alwaysOriginal)
        } else {
            checkMark.image = UIImage(systemName: "checkmark.rectangle")!.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        }
    }
    
}

