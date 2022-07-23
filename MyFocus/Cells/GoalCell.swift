//
//  GoalCell.swift
//  MyFocus
//
//  Created by Eva Madarasz on 23/07/2022.
//

import UIKit


final class CheckBox: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.cornerRadius = frame.size.width / 2.0
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setChecked(_ isChecked: Bool) {
        if isChecked {
            backgroundColor = .systemMint
        } else {
            backgroundColor = .systemBackground
        }
    }
    
   
}


class GoalCell: UITableViewCell {

let historyVC = HistoryListViewController()
   
    
    override func prepareForReuse() {
        let checkBox1 = CheckBox(frame: CGRect(x: 50, y: 100, width: 40, height: 40))
        let bgview = UIView.init(frame: self.frame)
        bgview.backgroundColor = .orange
        self.addSubview(bgview)
        self.addSubview(checkBox1)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20.0
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
