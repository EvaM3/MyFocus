//
//  TaskCell.swift
//  MyFocus
//
//  Created by Eva Sira Madarasz on 23/07/2022.
//

import UIKit

class TaskCell: UITableViewCell {
    
    class TaskCell: UITableViewCell {
        override func prepareForReuse() {
            let bgview = UIView.init(frame: self.frame)
            bgview.backgroundColor = .blue
            self.addSubview(bgview)
        }
     
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
