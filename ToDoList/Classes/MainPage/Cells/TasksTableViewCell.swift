//
//  TasksTableViewCell.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 20.09.21.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    @IBOutlet weak var taskTextLabel: UILabel!
    @IBOutlet weak var dateTextLabel: UILabel!
    @IBOutlet weak var buttonCheckMark: UIButton!
    
    // - Delegate
    var delegate: CompletedTaskDelegate?
    var data: Tasks?
    var index: IndexPath?
    
    // - init
    static let identifier = "TasksTableViewCellIdentifier"
    static func nib() -> UINib {
        let nib = UINib(nibName: "TasksTableViewCell", bundle: nil)
        return nib
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func set(data: Tasks?, index: IndexPath){
        self.data = data
        self.index = index
        taskTextLabel.text = self.data?.task
        dateTextLabel.text = self.data?.date
    }
    
    @IBAction func tapOnCheckMark(_ sander: Any) {
        guard let index = self.index else {
            return
        }
        if index.section == 0 {
            self.delegate?.didTapOnDone(index: index.row)
        }
    }
}
extension TasksTableViewCell{
    func configure(){
        setupView()
    }
    
    func setupView(){
        taskTextLabel.textColor = UIColor(named: "Dark_Font")
    }
}
