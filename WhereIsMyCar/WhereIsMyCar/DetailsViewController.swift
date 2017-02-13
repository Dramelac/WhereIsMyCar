//
//  DetailsViewController.swift
//  WhereIsMyCar
//
//  Created by Supinfo on 13/02/2017.
//  Copyright © 2017 Supinfo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var name: UILabel!
    
    
    var data:Position?
    override func viewDidLoad() {
        super.viewDidLoad()
        if data != nil{
            latitude.text = String(describing: data!.latitude)
            longitude.text = String(describing: data!.longitude)
            altitude.text = String(describing: data!.altitude) + " meters"
            comment.text = data!.comment
            name.text = data!.name
            //navigationController?.title = "Details : " + data!.name!
        }
        
    }
    
    @IBAction func goAction(_ sender: Any) {
        
        guard self.navigationController?.popToRootViewController(animated: true) != nil else {
            self.dismiss(animated: true, completion: nil)
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
