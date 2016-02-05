//
//  WaitingViewController.swift
//  FoldingCell
//
//  Created by Ulises Giacoman on 2/4/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit

class WaitingViewController: UIViewController {

    let heartImage = UIImageView()
    var direction:Bool = true
    var scale:NSTimeInterval = 30/200
    
    var tv = UITableView()
    var image_name:[String] = []
    var course:[String] = []
    var id:[String] = []
    var edescription:[String] = []
    var faculty:[String] = []
    var numStudents:[String] = []
    var organizer:[String] = []
    var created_at:[String] = []
    var user_id:[String] = []
    var location:[String] = []
    var end_t:[String] = []
    var courses:[String] = []
    var updated_at:[String] = []
    var department:[String] = []
    var start_t:[String] = []
    var name:[String] = []
    var members_attending:[String] = []
    var INFO: Event!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        waiting()
        Network.getEvent() { (success, message, events) -> Void in
            if(success) {
                print(events)
                if let pEvents = events.array {
                    for event in pEvents {
                        self.course.append(String(event["course"]))
                        self.id.append(String(event["start_t"]))
                        self.edescription.append(String(event["description"]))
                        self.faculty.append(String(event["faculty"]))
                        self.numStudents.append(String(event["number_attending"]))
                        self.organizer.append(String(event["organizer"]))
                        self.created_at.append(String(event["created_at"]))
                        self.user_id.append(String(event["user_id"]))
                        self.location.append(String(event["location"]))
                        self.end_t.append(String(event["end_t"]))
                        self.courses.append(String(event["course"]))
                        self.updated_at.append(String(event["updated_at"]))
                        self.department.append(String(event["department"]))
                        self.start_t.append(String(event["start_t"]))
                        self.name.append(String(event["name"]))
                        self.members_attending.append(String(event["members_attending"]))
                        
                    }
                }
                
                self.image_name = ["image1.jpg","image2.jpg","image3.jpg","image4.jpg","image5.jpg","image6.jpg","image3.jpg","image4.jpg","image5.jpg","image6.jpg","image3.jpg","image4.jpg","image5.jpg","image6.jpg"]
                print(self.numStudents)
                        self.INFO = Event(numStudents: self.numStudents, course: self.course, start_t: self.start_t, image_name: self.image_name, end_t: self.end_t, edescription: self.edescription, faculty: self.faculty, organizer: self.organizer, created_at: self.created_at, user_id: self.user_id, location: self.location, updated_at: self.updated_at, department: self.department, name: self.name)

                
                self.performSegueWithIdentifier("indexS", sender: self)
            } else {
                print("fuck me, fuck life")
            }
        }

    
    
    }
    func waiting () {
        heartImage.image = UIImage(named: "heart")
        heartImage.frame.size = CGSize(width: 100, height: 100)
        heartImage.center = CGPoint.init(x: view.bounds.midX, y: view.bounds.midY)
        view.addSubview(heartImage)
        sendDirection()
    }
    
    func sendDirection() {
        if(direction) {
            direction = false
        } else {
            direction = true
        }
        animateHeart(direction)
    }
    
    func animateHeart(isForward: Bool){
        if(isForward) {
            UIView.animateWithDuration(scale,
                animations: {
                    
                    self.heartImage.transform = CGAffineTransformMakeScale(0.9, 0.9)
                },
                completion: { finish in
                    self.sendDirection()
            })
        } else {
            UIView.animateWithDuration(scale,
                animations: {
                    
                    self.heartImage.transform = CGAffineTransformMakeScale(1/0.9, 1/0.9)
                },
                completion: { finish in
                    self.sendDirection()
            })
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "indexS") {
            
            let tripInfo = segue.destinationViewController as! MainTableViewController;
            
            tripInfo.content = self.INFO
        }
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
