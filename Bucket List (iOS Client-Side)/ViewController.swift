//
//  ViewController.swift
//  Bucket List (iOS Client-Side)
//
//  Created by R on 21/05/1443 AH.
//  Copyright © 1443 R. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var newtask: UITextField!
    @IBOutlet weak var tableview: UITableView!
    var apiarray:[taskAPI]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        TaskModel.getAllTasks { (data, res, err) in
            self.apidata(data: data)
        }

    }


    @IBAction func addTask(_ sender: UIButton) {
        if let new = newtask.text,!new.isEmpty{
            TaskModel.addTaskWithObjective(objective: new) { (data, res, err) in
                self.apidata(data: data)
                DispatchQueue.main.async {
                self.newtask.text = ""
                }
            }
        }
    }
    
    func apidata(data:Data?){
        if let data = data{
            do{
            let api = try JSONDecoder().decode([taskAPI].self, from: data)
                self.apiarray = api
                DispatchQueue.main.async {
                   self.tableview.reloadData()
                }
            }catch{
                print("no data")
            }
        }
    }
    
    func makeAlert(task:String,id:Int){
        var textField = UITextField()
        let alert = UIAlertController(title: "Update Task", message: "", preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.text = task
            textField = tf
        }
        alert.addAction(.init(title: "update", style: .default, handler: { (action) in
            TaskModel.UPdateTaskWithObjective(objective: textField.text!, id: id) { (data, res, err) in
                self.apidata(data: data)

            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiarray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        cell.textLabel?.text = apiarray![indexPath.row].objectiv
        cell.detailTextLabel?.text = apiarray![indexPath.row].created_at

        return cell
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "UPdate") { (ac, view, nil) in
            self.makeAlert(task: self.apiarray![indexPath.row].objectiv!, id: self.apiarray![indexPath.row].id!)
            print(self.apiarray![indexPath.row].id!)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "delete") { (ac, view, nil) in
            TaskModel.DeleteTaskWithObjective(id: self.apiarray![indexPath.row].id!) { (data, res, er) in
                self.apidata(data: data)

            }
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
}


struct taskAPI:Codable {
    let id:Int?
    let objectiv:String?
    let created_at :String?
    
}

