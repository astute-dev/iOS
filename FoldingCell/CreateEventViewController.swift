//
//  CreateEventViewController.swift
//  FoldingCell
//
//  Created by Ulises Giacoman on 2/5/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire

class CreateEventViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var departPicker: UIPickerView!
    @IBOutlet weak var courseNPicker: UIPickerView!

    
    @IBOutlet weak var datePicker: UIDatePicker!
    var hazards = ["a","b", "c"]
    var reasons = ["d", "e", "f"]
    var site = ["v","h","i","j"]
    var line = ["k", "l","m", "n"]
    let pickerData = ["CSCI","MATH","LAW","ENGL"]
    let pickerData2 = ["101","210","303","475","425","435"]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
                self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        departPicker.delegate = self
        courseNPicker.delegate = self

        departPicker.tag = 0
        courseNPicker.tag = 1
        datePicker.tag = 2
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int  {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 {
            return pickerData.count
        } else if pickerView.tag == 1 {
            return pickerData2.count
        } else if pickerView.tag == 2 {
            return  line.count
        } else if  pickerView.tag == 3 {
            return line.count
        }
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        if pickerView.tag == 0 {
            return pickerData[row]
        } else if pickerView.tag == 1 {
            return pickerData2[row]
        } else if pickerView.tag == 2 {
            return site[row]
        } else if pickerView.tag == 3 {
            return line[row]
        }
        
        return ""
    }

    
    @IBAction func sendRequest(sender: AnyObject) {
        
        
            /**
             My API
             POST https://astutedev.herokuapp.com/event
             */
             
             // Add Headers
            let headers = [
                "Content-Type":"application/x-www-form-urlencoded",
            ]
            
            // Form URL-Encoded Body
            let body = [
                "location":"A killer house",
                "course":"303",
                "end_t":"2016-02-05T00:47:51.107Z",
                "start_t":"2016-02-05T00:47:51.107Z",
                "user_id":"1",
                "description":"we love sports and we dont care who know",
                "department":"CSCI",
                "name":"study party",
                "faculty":"",
            ]
            
            // Fetch Request
            Alamofire.request(.POST, "https://astutedev.herokuapp.com/event", headers: headers, parameters: body, encoding: .URL)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    if (response.result.error == nil) {
                        debugPrint("HTTP Response Body: \(response.data)")
                    }
                    else {
                        debugPrint("HTTP Request failed: \(response.result.error)")
                    }
            }
            self.performSegueWithIdentifier("helloworld", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}