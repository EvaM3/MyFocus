//
//  GoalCell.swift
//  MyFocus
//
//  Created by Eva Madarasz on 23/07/2022.
//

import UIKit




class GoalCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    let checkBox1 = CheckBox(frame: CGRect(x: 50, y: 100, width: 40, height: 40))
    
    
    
    func configureCell(item: ListElement) {
        checkBox1.isChecked = item.isCompleted
        title.textAlignment = .left
        title.text = item.title
    }
    
    final class CheckBox: UIButton {
        
        
        let checkBoxImage = UIImage(systemName: "checkmark.rectangle.fill")!.withTintColor(.systemMint, renderingMode: .alwaysOriginal)
        let uncheckedBoxImage = UIImage(systemName: "checkmark.rectangle")!.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        
        
        
        
        // Bool for checking
        var isChecked: Bool = false {
            didSet{
                if isChecked == true {
                    self.setImage(checkBoxImage, for: [])
                } else {
                    self.setImage(uncheckedBoxImage, for: [])
                }
            }
        }
        
        override func awakeFromNib() {
            self.isUserInteractionEnabled = false
        }
        
        // later for button
        
        func buttonClicked(sender: UIButton) {
            if sender == self {
                if isChecked == true {
                    isChecked = false
                } else {
                    isChecked = true
                }
            }
        }
    }
    
    
}
