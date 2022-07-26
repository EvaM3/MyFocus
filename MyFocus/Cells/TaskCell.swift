//
//  TaskCell.swift
//  MyFocus
//
//  Created by Eva Madarasz on 23/07/2022.
//

import UIKit



class TaskCell: UITableViewCell {
    
    var isChecked = false
    
    @IBOutlet weak var title: UILabel!
    
    
    let historyVC = HistoryListViewController()
    let checkBox2 = CheckBox(frame: CGRect(x: 50, y: 100, width: 20, height: 20))
    
    
    @objc func didTapCheckbox() {
        checkBox2.toggle()
    }
    
    
    func configureCell(item: ListElement) {
        checkBox2.isChecked = item.isCompleted
        title.text = item.title
    }
    
    
    override func prepareForReuse() {
        let bgview = UIView.init(frame: self.frame)
        bgview.backgroundColor = .blue
        self.addSubview(bgview)
        self.addSubview(checkBox2)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func toggle() {
        self.isChecked = !isChecked
        
        if self.isChecked {
            backgroundColor = .systemMint
        } else {
            backgroundColor = .systemBackground
        }
    }
}
