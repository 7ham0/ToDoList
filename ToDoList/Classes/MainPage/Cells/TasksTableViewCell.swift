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
    
    var delegate: CompletedTaskDelegate?
    var data: Tasks?
    var index: Int?
    
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
    
    func set(data: Tasks?, index: Int){
        self.data = data
        self.index = index
        taskTextLabel.text = self.data?.task
        dateTextLabel.text = self.data?.date
//        guard let isDone = data?.isDone else {
//            return
//        }
//        buttonCheckMark.isHidden = isDone
    }
    
    @IBAction func tapOnCheckMark(_ sander: Any) {
        guard let index = self.index else {
            return
        }
        self.delegate?.didTapOnDone(index: index)
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
