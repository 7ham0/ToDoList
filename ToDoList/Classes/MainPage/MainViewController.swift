//
//  ViewController.swift
//  ToDoList
//
//  Created by Giorgi Shamugia on 20.09.21.
//

import UIKit
import CoreData

class MainViewController: BaseVC, Storyboardable {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTaskButton: UIButton!
    var navigationView = UIView(frame: CGRect(x: 0, y: 0, width: 230, height: 40))
    var searchBar = UISearchBar()
    
    // - Managers
    var dataSource: MainDataSource!
    var layoutService: MainViewLayoutService!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var sortType: sortTypes = .none
    var searchText: String? {
        didSet {
            fetchToDoList()
        }
    }
    
    // - Data
    var data:[Tasks]?
    
    // - DateFormatter
    lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd,hh:mm"
        return formatter
    }()
    
    // - Enum property
    enum sortTypes {
        case date
        case color
        case none
    }
    
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
        dataSource = MainDataSource(viewController: self, tableView: tableView, searchBar: searchBar)
    }
    
    func fetchToDoList(){
        do {
            let request = Tasks.fetchRequest() as NSFetchRequest<Tasks>
            
            //TODO: - Search Filter
            if  searchText != nil {
                let search = NSPredicate(format: "name contains[c] '\(searchText!)'")
                request.predicate = search
            }
            
            //Set the filtering and sorting request
            self.data = try context.fetch(request)
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
            searchText = nil
            try self.context.save()
        }
        catch{
            //TODO: Catch
        }
        self.tableView.reloadData()
        self.fetchToDoList()
    }
    
    func setupNavigationBarView(){
        navigationItem.title = "To Do"
        //TODO: Search
//        searchBar.frame = navigationView.bounds
//        navigationView.addSubview(searchBar)
//        self.navigationItem.titleView = navigationView
        
    }
}

