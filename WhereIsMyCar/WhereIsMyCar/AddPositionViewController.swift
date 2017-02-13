//
//  AddPositionViewController.swift
//  WhereIsMyCar
//
//  Created by Supinfo on 12/02/2017.
//  Copyright © 2017 Supinfo. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class AddPositionViewController: UIViewController {
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var data:CLLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
        if data != nil{
            latitude.text = String(describing: data!.coordinate.latitude)
            longitude.text = String(describing: data!.coordinate.longitude)
            altitude.text = String(describing: data!.altitude)
        }
        //activityIndicator.transform = CGAffineTransformMakeScale(0.75, 0.75);
        activityIndicator.isHidden = true
        
    }
    
    @IBAction func SavePosition(_ sender: Any) {
        
        if (self.name.text?.isEmpty)!{
            errorMessage.text = "Name is empty"
            return
        }
        activityIndicator.isHidden = false
        saveButton.isHidden = true
        
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Position", in: context)!
        let position = NSManagedObject(entity: entity, insertInto: context)
        
        position.setValue(name.text, forKey: "name")
        position.setValue(comment.text, forKey: "comment")
        position.setValue(Double(altitude.text!), forKey: "altitude")
        position.setValue(Double(longitude.text!), forKey: "longitude")
        position.setValue(Double(latitude.text!), forKey: "latitude")
        
        do {
            try context.save()
            self.errorMessage.text = ""
            
        } catch {
            print(error.localizedDescription)
            self.errorMessage.text = "Unknown error"
            
            activityIndicator.isHidden = true
            saveButton.isHidden = false
            
            return
        }
        
        guard self.navigationController?.popViewController(animated: true) != nil else {
            self.dismiss(animated: true, completion: nil)
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

