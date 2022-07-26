//
//  GoalCell.swift
//  MyFocus
//
//  Created by Eva Madarasz on 23/07/2022.
//

import UIKit


final class CheckBox: UIView {
    
 var isChecked = false
    
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
    
    func toggle() {
        self.isChecked = !isChecked
        
        if self.isChecked {
            backgroundColor = .systemMint
        } else {
            backgroundColor = .systemBackground
        }
    }
}


class GoalCell: UITableViewCell {

 
    @IBOutlet weak var title: UILabel!
    
    let checkBox1 = CheckBox(frame: CGRect(x: 50, y: 100, width: 40, height: 40))
   
    override func prepareForReuse() {
        let bgview = UIView.init(frame: self.frame)
        bgview.backgroundColor = .orange
        self.addSubview(bgview)
        self.addSubview(checkBox1)
        
        
//        let gesture = UIGestureRecognizer(target: self, action: #selector(didTapCheckbox))
//        checkBox1.addGestureRecognizer(gesture)
    }
    
    @objc func didTapCheckbox() {
        checkBox1.toggle()
    }
    
    
    func configureCell(item: ListElement) {
        checkBox1.isChecked = item.isCompleted
        title.text = item.title
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
