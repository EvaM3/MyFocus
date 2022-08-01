//
//  GoalCell.swift
//  MyFocus
//
//  Created by Eva Madarasz on 23/07/2022.
//

import UIKit


final class CheckBox: UIView {
    
 //var isChecked = false
    
  let checkedBox = UIImage(named: "CheckBoxChecked")! as UIImage
  let uncheckedBox = UIImage(named: "CheckBoxUnchecked")! as UIImage
    
// Bool for checking
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.checkedBox
                      } else {
                          self.uncheckedBox
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
    

class GoalCell: UITableViewCell {

 
    @IBOutlet weak var title: UILabel!
    
    let checkBox1 = CheckBox(frame: CGRect(x: 50, y: 100, width: 40, height: 40))
   
    
        
    func configureCell(item: ListElement) {
        checkBox1.isChecked = item.isCompleted
        title.textAlignment = .left
         title.text = item.title
    }
    
//    override func prepareForReuse() {
//        let bgview = UIView.init(frame: self.frame)
//        bgview.backgroundColor = .orange
//        self.addSubview(bgview)
//        self.addSubview(checkBox1)
        
        
//        let gesture = UIGestureRecognizer(target: self, action: #selector(didTapCheckbox))
//        checkBox1.addGestureRecognizer(gesture)
  //  }
    
 
  //  }
    
    
  
    
}
