//
//  MainDataSource.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 20.09.21.
//

import UIKit

class MainDataSource: NSObject {
    
    private unowned let viewController: MainViewController
    private let tableView: UITableView
    
    init(viewController: MainViewController, tableView: UITableView) {
        self.viewController = viewController
        self.tableView = tableView
        super.init()
        configure()
    }
}

extension MainDataSource: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewController.data?.filter({$0.isDone != true}).count ?? 0
        case 1:
            return viewController.data?.filter({$0.isDone == true}).count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.identifier, for: indexPath) as! TasksTableViewCell
        
        switch indexPath.section {
        case 0:
            //todo celltypes for changing data
            let data = viewController.data?.filter({$0.isDone != true})
            cell.delegate = self
            cell.set(data: data?[indexPath.row], index: indexPath.row)
            return cell
        case 1:
            let data = viewController.data?.filter({$0.isDone == true})[indexPath.row]
            cell.set(data: data, index: indexPath.row)
            cell.buttonCheckMark.layer.opacity = 0.3
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //SwipeAction
        let action = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            
            let data = (self.viewController.data?[indexPath.row])!
            //DeleteData
            self.viewController.context.delete(data)
            do {
                try self.viewController.context.save()
            }
            catch {
                //TODO: Catch
            }
            self.viewController.fetchToDoList()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Tasks"
        case 1:
            return "Done Tasks"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 40
    }
}

extension MainDataSource {
    func configure(){
        configureTableView()
        setupCells()
    }
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    func setupCells(){
        tableView.register(TasksTableViewCell.nib(), forCellReuseIdentifier: TasksTableViewCell.identifier)
    }
}

extension MainDataSource: CompletedTaskDelegate {
    func didTapOnDone(index: Int) {
        let data = (self.viewController.data?.filter({$0.isDone != true})[index])
        guard let newData = data else {
            return
        }
        newData.isDone = true
        do {
            try viewController.context.save()
        }
        catch {
            //TODO: Catch
        }
        self.viewController.fetchToDoList()
    }
    
}
