//
//  AddPositionViewController.swift
//  WhereIsMyCar
//
//  Created by Supinfo on 12/02/2017.
//  Copyright © 2017 Supinfo. All rights reserved.
//

import UIKit
import MapKit

class AddPositionViewController: UIViewController {
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var successMessage: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var data:CLLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
        if data != nil{
            latitude.text = String(describing: data!.coordinate.latitude)
            longitude.text = String(describing: data!.coordinate.longitude)
            altitude.text = String(describing: data!.altitude)
        }
        
    }
    
    @IBAction func SavePosition(_ sender: Any) {
        
        if (self.name.text?.isEmpty)!{
            errorMessage.text = "Name is empty"
            return
        }
        
        appDelegate.persistentContainer.performBackgroundTask{ (backgroundContext) in
            let positionEntity = Position(context: backgroundContext)
            
            positionEntity.comment = self.comment.text
            positionEntity.name = self.name.text
            positionEntity.altitude = Double(self.altitude.text!)!
            positionEntity.longitude = Double(self.longitude.text!)!
            positionEntity.latitude = Double(self.latitude.text!)!
            
            do {
                try backgroundContext.save()
                self.errorMessage.text = ""
                self.successMessage.text = self.name.text! + " successfully added"
            } catch {
                print(error.localizedDescription)
                self.errorMessage.text = "Unknown error"
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

