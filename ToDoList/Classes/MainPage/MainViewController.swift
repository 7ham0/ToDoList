//
//  ViewController.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 20.09.21.
//

import UIKit

class MainViewController: BaseVC, Storyboardable {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTaskButton: UIButton!
    
    // - Managers
    var dataSource: MainDataSource!
    var layoutService: MainViewLayoutService!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // - Data
    var data:[Tasks]?
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd,hh:mm"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func addTaskButtonAction(_ sender: Any) {
        let vc = AddTaskViewController.instantiate()
        vc.delegate = self.layoutService
        vc.modalPresentationStyle = .overCurrentContext
        present(vc)
    }
}

extension MainViewController {
    func configure(){
        setupLayoutService()
        setupDataSource()
        setupNavigationBarView()
        fetchToDoList()
    }
    
    func setupLayoutService(){
        layoutService = MainViewLayoutService(viewController: self)
    }
    
    func setupDataSource(){
        dataSource = MainDataSource(viewController: self, tableView: tableView)
    }
    
    func fetchToDoList(){
        do {
            self.data = try context.fetch(Tasks.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            //TODO: catch
        }
    }
    
    func saveTaskToDatabase(){
        //Save Data
        do {
            try self.context.save()
        }
        catch{
            //TODO: Catch
        }
        self.tableView.reloadData()
        self.fetchToDoList()
    }
    
    func setupNavigationBarView(){
        let navigationTitle = "To Do"
        self.navigationItem.title = navigationTitle
    }
}

