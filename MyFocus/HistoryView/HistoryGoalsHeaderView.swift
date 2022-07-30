//
//  HistoryGoalsHeaderView.swift
//  MyFocus
//
//  Created by Eva Madarasz on 30/07/2022.
//

import UIKit



class HistoryGoalsHeaderView: UIView {
 
    var goals = "many"
    var results = "few"
    var dateArray = ["09-07-2022","10-07-2022","11-07-2022","12-07-2022"]
  //  var goalResults = " \(self.goals) goals out of \(self.results) completed "
    
    func headerLabel() {
        let headerView = HistoryGoalsHeaderView()
        let label = UILabel()
      //  label.text = goalResults
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .green
       
    }
   
    
    @IBOutlet var contentView: UIView!
    
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           commonInit()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           commonInit()
       }
       
       override var intrinsicContentSize: CGSize {
           return CGSize(width: UIView.noIntrinsicMetric, height: 40)
       }
       
       private func commonInit() {
           let bundle = Bundle(for: HistoryGoalsHeaderView.self)
           bundle.loadNibNamed("HistoryGoalsHeaderView", owner: self, options: nil)
           addSubview(contentView)
         
           
           contentView.translatesAutoresizingMaskIntoConstraints = false
           contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
           contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
           contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
           contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
       }
    
}
