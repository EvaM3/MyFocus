//
//  TaskCell.swift
//  MyFocus
//
//  Created by Eva Madarasz on 23/07/2022.
//

import UIKit



class TaskCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    
    
    let historyVC = HistoryListViewController()
    
    
class TaskCheckBox: UIButton {
    
    
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
  
  
//    func configureCell(item: ListElement) {
//        checkBoxImage.isChecked = item.isCompleted
//        title.text = item.title
//    }
    
    
    override func prepareForReuse() {
        let bgview = UIView.init(frame: self.frame)
       // bgview.backgroundColor = .blue
        self.addSubview(bgview)
      
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
