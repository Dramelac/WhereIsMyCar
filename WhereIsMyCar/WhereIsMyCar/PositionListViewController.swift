//
//  PositionListViewController.swift
//  WhereIsMyCar
//
//  Created by Supinfo on 12/02/2017.
//  Copyright © 2017 Supinfo. All rights reserved.
//

import UIKit
import MapKit

class PositionListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    
    var positionContainer: [Position] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        do {
            positionContainer.append(contentsOf: try appDelegate.persistentContainer.viewContext.fetch(Position.fetchRequest()) as [Position])
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    func clearData(object: Position){
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(object)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return positionContainer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = positionContainer[indexPath.row].name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            clearData(object: positionContainer[indexPath.row])
            positionContainer.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    
}
